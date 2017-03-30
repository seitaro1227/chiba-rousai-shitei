class HospitalsController < ApplicationController
  def index
    jurisdiction = Jurisdiction.find_by(roman: params[:jurisdiction])
    @current_location = location_params(params[:current_location])
    @jurisdictions = Jurisdiction.all
    @jurisdiction_selected = params[:jurisdiction] || 'chiba'
    @hospitals = search_hospital(params, jurisdiction)
    respond_to do |format|
      format.html
      format.geojson {render :json => geojson(@hospitals)}
    end
  end

  private
  def search_hospital(params, jurisdiction)
    current_location = location_params(params[:current_location])
    rel = Hospital
    if params[:km].present? and current_location[:result]
      rel = rel.within(params[:km].to_i, origin: [current_location[:lat], current_location[:lng]])
    end
    rel = rel.where('subject LIKE ?',"%#{params[:subject]}%") if params[:subject].present?
    rel = rel.where('name LIKE ?',"%#{params[:name]}%") if params[:name].present?
    rel = rel.where("jurisdiction_id = ?", jurisdiction.id) if jurisdiction.present?
    rel = rel.all if(params[:subject].blank? and jurisdiction.blank? and params[:name].blank? and params[:km].blank?)
    rel
  end

  def location_params(current_location_param)
    if current_location_param.present? and (splited = current_location_param.split(',')) and splited.size == 2
      {lat:splited[0], lng: splited[1], result: true}
    else
      {lat:'',lng:'', result: false}
    end
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
           :subject      => hospital.subject,
           :zip_code     => hospital.zip_code,
       }
      }
    end

    {"type" => "FeatureCollection",
     "features" => features
    }
  end
end
