class HospitalsController < ApplicationController
  def index
    jurisdiction = Jurisdiction.find_by(roman: params[:jurisdiction])
    @current_location = location_params(params)
    @subject_ids = []
    @subject_ids = params[:subjects][:ids] if params[:subjects].present?
    @jurisdictions = Jurisdiction.all
    @subjects = Subject.all
    @jurisdiction_selected = params[:jurisdiction] || 'kashiwa'
    @hospitals = Hospital.search(params)
    @center_of_gravity = center_of_gravity(@hospitals)
    @stations = Station.all
    @geojson = geojson(@hospitals)
    respond_to do |format|
      format.html
      format.geojson {render :json => @geojson}
    end
  end

  private

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
