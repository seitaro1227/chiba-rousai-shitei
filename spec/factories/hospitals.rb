FactoryGirl.define do
  factory :hospital do
    sequence(:number){|n| "212#{format('%04d', n)}"}
    name 'dummy病院名'
    address '松戸市栄町西２－８７０－１'
    phone_number '000-000-0000'
    zip_code '271-8587'
    niji ''
    saikei ''
    factory :nichidai_matsudo_shika do
      number '1231766'
      name "学校法人　日本大学　日本大学松戸歯学部付属病院"
      zip_code '271-8587'
      address '松戸市栄町西２－８７０－１'
      orgin_subject '内・外・脳・耳・歯・矯歯・歯口・小'
      phone_number '047-360-9511'
      latitude 35.8099242
      longitude 139.8991869
    end
  end
end