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
    @center_of_gravity = center_of_gravity(@hospitals)
    @stations = Station.all
    respond_to do |format|
      format.html
      format.geojson
    end
  end

  def search
    @hospitals = Hospital.search(params)
    respond_to do |format|
      format.json
      format.geojson
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
end
