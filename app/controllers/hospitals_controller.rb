class HospitalsController < ApplicationController
  def index
    jurisdiction = Jurisdiction.find_by(roman: params[:jurisdiction])
    @hospitals = search_hospital(params, jurisdiction)
    # @markers = markers(@hospitals) if(@hospitals.present?)
    @area_options = %w"千葉 船橋 柏 銚子 木更津 茂原 成田 東金".map{|i|[i,i]}
    @km_options = [%w"500m 1km 2km 3km 5km 10km", %w"0.5 1 2 3 5 10"].transpose
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
