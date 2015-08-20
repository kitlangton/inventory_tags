class Color < ActiveRecord::Base
  has_many :tags

  validates :name, presence: true, uniqueness: true
  validates :hex, presence: true

  def dark?
    _,_,b = Colorable::Color.new(self.hex).hsb
    b < 50
  end

  def to_s
    self.name
  end
end
