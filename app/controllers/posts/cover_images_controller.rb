class Posts::CoverImagesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!
  before_action :set_post

  def destroy
    @post.cover_image.purge_later

    respond_to do |format|
      format.html { redirect_to edit_post_path(@post) }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@post, :cover_image)) }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end