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

class Jurisdiction < ApplicationRecord
  validates :name, presence:true, uniqueness: true
  validates :roman,presence:true, uniqueness: true, format: /\A[a-z_\d]+\z/
  has_many :hospitals
end
