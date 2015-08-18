class ColorPolicy < ApplicationPolicy
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

  def destroy?
    if user.role == "Area" || user.admin?
      true
    end
  end

  def index?
    true
  end
end
