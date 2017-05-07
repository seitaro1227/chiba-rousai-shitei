class Station < ApplicationRecord
  validates :name, :presence => true, uniqueness: true

  geocoded_by :name
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  after_validation :geocode, if: :name_changed?
end
