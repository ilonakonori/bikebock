class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.recipient_id == user.id || record.user_id == user.id
  end

  def create?
    true
  end

  def update?
    record.accepted == nil && record.recipient_id == user.id
  end
end
