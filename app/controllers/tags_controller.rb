class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    tagged_users = ActsAsTaggableOn::Tagging.where(tag_id: @tag.id).select(:taggable_id)
    @tagged = filter_blocked(tagged_users, 'taggable_id')
    authorize @tag
    update_tracking
  end

  def index
    @tags = policy_scope(ActsAsTaggableOn::Tag).all.order(name: :asc)
    update_tracking
  end

  def filter_blocked(this_users, this_id)
     # don't display users that current_user blocked
    blocked_users = current_user.blockings.map { |b| b.blocked_user }
    # don't display users that blocked current_user
    user_blocked_by = Blocking.all.select do |b|
                        if b.blocked_user == current_user.id
                          b
                        end
                      end.map { |b| b.user_id }

    this_users.reject do |t|
      if blocked_users.include?(t[this_id]) || user_blocked_by.include?(t[this_id])
        t
      end
    end
  end

  def update_tracking
    tracking = Tracking.find_by(user: current_user.id)
    tracking.update!(location: request.url, location_time: Time.now)
  end
end

