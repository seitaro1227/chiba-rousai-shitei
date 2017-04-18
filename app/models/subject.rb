class Subject < ApplicationRecord
  validates :code, presence: true, uniqueness: true, length:{is: 3}, format: /\A\d{3}\Z/
  validates :name, presence: true, uniqueness: true
  has_many :hospital_subjects, :dependent => :destroy
  has_many :hospitals, :through => :hospital_subjects
end
