class Jurisdiction < ApplicationRecord
  validates :name, presence:true, uniqueness: true
  validates :roman,presence:true, uniqueness: true, format: /\A[a-z_\d]+\z/
  has_many :hospitals
end
