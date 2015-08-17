class UserPolicy < ApplicationPolicy
  def index?
    if user.role == "Area" || user.admin?
      true
    end
  end

  def create?
    if user.role == "Area" || user.admin?
      true
    end
  end

  def update?
    if user.admin?
      true
    elsif user.role == "Area"
      if user.area == record.area
        true
      end
    end
  end

  def set_area?
    if user.admin?
      true
    end
  end

  def set_role?
    if user.admin?
      true
    end
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(area: user.area)
      end
    end
  end
end
