class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def presence?
    true
  end

  def bookmarks?
    true
  end

  def tagged?
    true
  end

  def notifications?
    true
  end

  def unread?
    true
  end
end
