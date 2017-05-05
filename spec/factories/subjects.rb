FactoryGirl.define do
  factory :subject do
    sequence(:code){|n| "8#{format('%02d',n)}"}
    sequence(:name){|n| "科目名_#{n}"}
    sequence(:short_name){|n| "ｶﾓｸﾒｲ_#{n}"}

    factory :naika do
      code '010'
      name '内科'
      short_name '内'
    end
    factory :geka do
      code '110'
      name '外科'
      short_name '外'
    end
    factory :shika do
      code '360'
      name '歯科'
      short_name '歯'
    end
  end
end