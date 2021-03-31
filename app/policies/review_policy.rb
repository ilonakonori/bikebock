class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.booking.participant == user.id
  end
end
