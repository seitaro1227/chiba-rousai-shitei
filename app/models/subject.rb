# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  code       :string
#  name       :string
#  short_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subjects_on_code  (code) UNIQUE
#  index_subjects_on_name  (name) UNIQUE
#

class Subject < ApplicationRecord
  validates :code, presence: true, uniqueness: true, length:{is: 3}, format: /\A\d{3}\Z/
  validates :name, presence: true, uniqueness: true
  has_many :hospital_subjects, :dependent => :destroy
  has_many :hospitals, :through => :hospital_subjects
end
