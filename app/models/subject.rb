class Subject < ApplicationRecord
  has_many :hospital_subjects, :dependent => :destroy
  has_many :hospitals, :through => :hospital_subjects
end
