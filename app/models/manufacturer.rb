class Manufacturer < ActiveRecord::Base
  has_many :tags
  validates :name, presence: :true
end
