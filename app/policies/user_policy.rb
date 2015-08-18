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
    if user.role == "Area" || user.admin?
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
        scope.where.not(admin: true).where.not(role: "Area")
      end
    end
  end
end
