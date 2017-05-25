# == Schema Information
#
# Table name: hospital_subjects
#
#  id          :integer          not null, primary key
#  hospital_id :integer
#  subject_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_hospital_subjects_on_hospital_id  (hospital_id)
#  index_hospital_subjects_on_subject_id   (subject_id)
#

class HospitalSubject < ApplicationRecord
  belongs_to :hospital
  belongs_to :subject
end
