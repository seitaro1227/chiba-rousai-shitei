FactoryGirl.define do
  factory :jurisdiction do
    sequence(:name){|n| "監督署#{n}"}
    sequence(:roman){|n| "kantokusyo_#{n}"}
    factory :kashiwa do
      name '柏'
      roman 'kashiwa'
    end
  end
end