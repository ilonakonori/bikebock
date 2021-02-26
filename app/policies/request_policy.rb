class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.recipient_id == user.id || record.sender_id == user.id
  end

  def create?
    true
  end

  def destroy?
    record.recipient_id == user.id
  end
end
