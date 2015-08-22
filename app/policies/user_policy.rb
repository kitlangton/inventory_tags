class UserPolicy < ApplicationPolicy
  def index?
    true if user.role == 'Area' || user.admin?
  end

  def create?
    true if user.role == 'Area' || user.admin?
  end

  def update?
    true if user.role == 'Area' || user.admin?
  end

  def set_role?
    true if user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where.not(admin: true).where.not(role: 'Area')
      end
    end
  end
end
