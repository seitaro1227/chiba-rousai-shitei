class HospitalSubject < ApplicationRecord
  belongs_to :hospital
  belongs_to :subject
end
