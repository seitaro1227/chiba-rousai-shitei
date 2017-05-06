class Hospital < ApplicationRecord
  has_many :hospital_subjects, dependent: :destroy
  has_many :subjects, through: :hospital_subjects
  validates :name, presence: true
  validates :address, presence: true
  validates :number, presence: true, uniqueness: true
  validates :zip_code, presence: true

  geocoded_by :address
  acts_as_mappable default_units: :kms,
                   default_formula: :sphere,
                   distance_field_name: :distance,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude
  after_validation :geocode, if: :address_changed?
  belongs_to :jurisdiction

  scope :within_near, ->(params, current_location) {
    if current_location[:result] and params[:km].present?
      within(params[:km], origin: [current_location[:lat], current_location[:lng]])
    end
  }
  scope :order_by_distance,->(current_location){
    by_distance(origin: [current_location[:lat], current_location[:lng]]) if current_location[:result]
  }
  scope :where_subjects, ->(params) {
    where(subjects: {id: params[:subjects][:ids]}) if params[:subjects].present?
  }
  scope :like_name, ->(params) {
    where('name LIKE ?', "%#{params[:name]}%") if params[:name].present?
  }
  scope :eq_jurisdiction, ->(jurisdiction) {
    where(jurisdiction: jurisdiction) if jurisdiction.present?
  }

  # paramsでhospitalを検索します
  def self.search(params)
    current_location = location_params(params)
    jurisdiction = Jurisdiction.find_by(roman: params[:jurisdiction])
    Hospital.includes(:jurisdiction,:subjects)
              .where_subjects(params)
              .like_name(params)
              .eq_jurisdiction(jurisdiction)
              .within_near(params,current_location)
              .order_by_distance(current_location)
  end

  def self.location_params(params)
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
end
