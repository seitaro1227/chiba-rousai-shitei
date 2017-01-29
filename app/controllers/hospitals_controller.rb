class HospitalsController < ApplicationController
  def index
    @hospitals = search_hospital(params)
    @markers = markers(@hospitals) unless(@hospitals.nil?)
    @area_options = %w"千葉 船橋 柏 銚子 木更津 茂原 成田 東金".map{|i|[i,i]}
  end

  private
  def search_hospital(params)
    rel = Hospital
    rel = rel.where('subject LIKE ?',"%#{params[:subject]}%") if params[:subject].present?
    rel = rel.where('name LIKE ?',"%#{params[:name]}%") if params[:name].present?
    rel = rel.where("jurisdiction = ?", params[:jurisdiction]) if params[:jurisdiction].present?
    rel = rel.all if( not params[:subject].present? and not params[:jurisdiction].present? and not params[:name].present?)
    rel
  end
  def markers(hospitals)
    Gmaps4rails.build_markers hospitals do|hospital, marker|
      marker.lat hospital.latitude
      marker.lng hospital.longitude
      marker.title hospital.name
      marker.infowindow render_to_string(:partial => "/hospitals/info_window", :locals => { :hospital => hospital})
    end
  end
end
