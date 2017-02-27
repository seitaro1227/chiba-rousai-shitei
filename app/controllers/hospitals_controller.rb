class HospitalsController < ApplicationController
  def index
    @geolocation = featch_geolocation
    @hospitals = search_hospital(params)
    @markers = markers(@hospitals) if(@hospitals.present?)
    @area_options = %w"千葉 船橋 柏 銚子 木更津 茂原 成田 東金".map{|i|[i,i]}
    @km_options = [%w"500m 1km 2km 3km 5km 10km", %w"0.5 1 2 3 5 10"].transpose
  end

  def set_geolocation
    @km_options = [%w"500m 1km 2km 3km 5km 10km", %w"0.5 1 2 3 5 10"].transpose
     if (params[:lat].present? or params[:lng].present?)
       cookies[:geolocation] = {expires: 1.hour.from_now,
                                value: JSON.generate(lat: params[:lat].to_f,lng: params[:lng].to_f)}
       render :partial => 'hospitals/geolocation_area'
     else
       render "<div>取得失敗</div>"
     end
  end

  private
  def search_hospital(params)
    rel = Hospital
    rel = rel.within(params[:km].to_i, origin: [@geolocation['lat'],@geolocation['lng']]) if params[:km].present? and @geolocation.present?
    rel = rel.where('subject LIKE ?',"%#{params[:subject]}%") if params[:subject].present?
    rel = rel.where('name LIKE ?',"%#{params[:name]}%") if params[:name].present?
    rel = rel.where("jurisdiction = ?", params[:jurisdiction]) if params[:jurisdiction].present?
    rel = rel.all if(params[:subject].blank? and params[:jurisdiction].blank? and params[:name].blank? and params[:km].blank?)
    rel
  end

  def featch_geolocation
    if cookies[:geolocation].present?
      values = JSON.parse(cookies[:geolocation])
    else
      {}
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
