# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    user.admin? || record == user
  end

  def update?
    edit?
  end

  def destroy?
    user.admin? && record != user
  end
end
