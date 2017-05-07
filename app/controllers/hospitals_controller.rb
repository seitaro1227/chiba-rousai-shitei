class HospitalsController < ApplicationController
  def index
    jurisdiction = Jurisdiction.find_by(roman: params[:jurisdiction])
    @current_location = Hospital.location_params(params)
    @subject_ids = []
    @subject_ids = params[:subjects][:ids] if params[:subjects].present?
    @jurisdictions = Jurisdiction.all
    @subjects = Subject.all
    @jurisdiction_selected = params[:jurisdiction] || 'kashiwa'
    @hospitals = Hospital.search(params)
    @stations = Station.all
    respond_to do |format|
      format.html
      format.geojson
    end
  end

  def search
    @hospitals = Hospital.search(params)
    respond_to do |format|
      format.html
      format.js
      format.json
      format.geojson
    end
  end

end
