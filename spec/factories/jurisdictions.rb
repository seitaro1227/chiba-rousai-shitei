# == Schema Information
#
# Table name: jurisdictions
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  roman      :string
#
# Indexes
#
#  index_jurisdictions_on_name   (name) UNIQUE
#  index_jurisdictions_on_roman  (roman) UNIQUE
#

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
