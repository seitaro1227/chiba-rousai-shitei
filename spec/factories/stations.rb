# == Schema Information
#
# Table name: stations
#
#  id         :integer          not null, primary key
#  name       :string
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_stations_on_name  (name) UNIQUE
#

FactoryGirl.define do
  factory :station do
    sequence(:name){|n| "駅名#{n}"}
    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
    factory :kashiwa_station do
      name '柏'
      latitude 35.86236299999999
      longitude 139.971213
    end
  end
end
