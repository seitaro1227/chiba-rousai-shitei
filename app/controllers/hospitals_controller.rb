class HospitalsController < ApplicationController
  def index
    jurisdiction = Jurisdiction.find_by(roman: params[:jurisdiction])
    @current_location = location_params(params)
    @subject_ids = []
    @subject_ids = params[:subjects][:ids] if params[:subjects].present?
    @jurisdictions = Jurisdiction.all
    @jurisdiction_selected = params[:jurisdiction] || 'kashiwa'
    @hospitals = search_hospital(params, jurisdiction)
    @center_of_gravity = center_of_gravity(@hospitals)
    @stations = Station.all
    @geojson = geojson(@hospitals)
    respond_to do |format|
      format.html
      format.geojson {render :json => @geojson}
    end
  end

  private

  # location(geo_location,station)
  # geo_location
  # station(Station.id)
  # km(1,2,3,5)
  # jurisdiction(Jurisdiction.roman)
  def search_hospital(params, jurisdiction)
    current_location = location_params(params)

    rel = Hospital.includes(:jurisdiction,:subjects)
    if current_location[:result] and params[:km].present?
      rel = rel.within(params[:km].to_i, origin: [current_location[:lat], current_location[:lng]])
    end
    rel = rel.where(:subjects => {:id => params[:subjects][:ids]}) if params[:subjects].present?
    rel = rel.where('name LIKE ?',"%#{params[:name]}%") if params[:name].present?
    rel = rel.where(:jurisdiction => jurisdiction) if jurisdiction.present?
    rel = rel.all if(jurisdiction.blank? and params[:name].blank? and params[:km].blank? and params[:subjects].blank?)
    rel
  end

  def location_params(params)
    empty = {lat: '', lng: '', result: false}

    case params[:location]
      when 'station'
        station = Station.find_by(:id => params[:station])
        if station
          {lat: station.latitude, lng: station.longitude, result: true}
        else
          empty
        end
      when 'geo_location'
        geo_location = params[:geo_location]
        if geo_location.present? and (splited = geo_location.split(',')) and splited.size == 2
          {lat: splited.first, lng: splited.second, result: true}
        else
          empty
        end
      else
        empty
    end
  end

  # 複数の病院の中心(重心)座標を返します
  # 複数の病院が空の場合は[NaN,NaN]が返ります
  def center_of_gravity(hospitals)
    latlng = hospitals.select(&:geocoded?).map{|x| [x.latitude, x.longitude] }
    south, north = latlng.minmax { |x, y| x[0]<=>y[0] }
    east, west = latlng.minmax { |x, y| x[1]<=>y[1] }
    Geocoder::Calculations.geographic_center([east, south, west, north])
  end

  def geojson(hospitals)
    features = hospitals.map do |hospital|
      {:type => "Feature",
       :geometry => {"type" => "Point", "coordinates" => [hospital.longitude, hospital.latitude]},
       :properties => {
           :number       => hospital.number,
           :name         => hospital.name,
           :address      => hospital.address,
           :jurisdiction_name => hospital.jurisdiction.name,
           :phone_number => hospital.phone_number,
           :saikei       => hospital.saikei,
           :niji         => hospital.niji,
           :subject      => hospital.orgin_subject,
           :zip_code     => hospital.zip_code,
       }
      }
    end

    {"type" => "FeatureCollection",
     "features" => features
    }
  end
end
