class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @tagged = ActsAsTaggableOn::Tagging.where(tag_id: @tag.id).select(:taggable_id)
    authorize @tag
  end
end
