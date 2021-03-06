class RidePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  def fav?
    record.user != user
  end

  def unfav?
    #user.favorited?(record)
    true
  end

  private

  def user_is_owner?
    record.user == user
  end
end
