class TagPolicy < ApplicationPolicy
  def new?
    if user.role == "Area" || user.admin?
      true
    end
  end

  def index?
    true
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
