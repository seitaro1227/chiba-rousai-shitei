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