class ColorPolicy < ApplicationPolicy
  def create?
    true if user.role == 'Area' || user.admin?
  end

  def update?
    true if user.role == 'Area' || user.admin?
  end

  def destroy?
    true if user.role == 'Area' || user.admin?
  end

  def index?
    true
  end
end
