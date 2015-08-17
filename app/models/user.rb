class User < ActiveRecord::Base
  belongs_to :area
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def display_area
    if area
      area.name
    else
      "N/A"
    end
  end

  def type
    return "Admin" if admin?
    "Store"
  end
end
