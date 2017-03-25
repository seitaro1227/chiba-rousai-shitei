class HospitalsController < ApplicationController
  def index
    jurisdiction = Jurisdiction.find_by(roman: params[:jurisdiction])
    @jurisdictions = Jurisdiction.all
    @jurisdiction_selected = params[:jurisdiction] || 'chiba'
    @hospitals = search_hospital(params, jurisdiction)
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

  def markers(hospitals)
    hospitals.map do |hospital|
      { lat: hospital.latitude,
        lng: hospital.longitude,
        marker_title: hospital.name,
        infowindow: render_to_string(:partial => "/hospitals/info_window", :locals => { :hospital => hospital})
      }
    end
  end
end
