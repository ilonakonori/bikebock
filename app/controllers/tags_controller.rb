class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @tagged = ActsAsTaggableOn::Tagging.where(tag_id: @tag.id).select(:taggable_id)
    authorize @tag
    update_tracking
  end

  def index
    @tags = policy_scope(ActsAsTaggableOn::Tag).all.order(name: :asc)
    update_tracking
  end

  def update_tracking
    tracking = Tracking.find_by(user: current_user.id)
    tracking.update!(location: request.url, location_time: Time.now)
  end
end
