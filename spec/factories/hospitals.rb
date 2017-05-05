FactoryGirl.define do
  factory :hospital do
    sequence(:number){|n| "212#{format('%04d', n)}"}
    name 'dummy病院名'
    address '松戸市栄町西２－８７０－１'
    phone_number '000-000-0000'
    zip_code '271-8587'
    niji ''
    saikei ''
  end
end


# has_many :subjects, :through => :hospital_subjects
# has_many :hospital_subjects, :dependent => :destroy
# belongs_to :jurisdiction

# t.string :address
# t.string :name
# t.string :niji
# t.string :number
# t.string :phone_number
# t.string :saikei
# t.string :zip_code
# t.float :latitude
# t.float :longitude