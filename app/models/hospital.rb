class Hospital < ApplicationRecord
  has_many :hospital_subjects, :dependent => :destroy
  has_many :subjects, :through => :hospital_subjects

  geocoded_by :address
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  after_validation :geocode, if: :address_changed?
  belongs_to :jurisdiction
end
