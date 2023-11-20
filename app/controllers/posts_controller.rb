class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @posts = if user_signed_in?
      Post.sorted
    else
      Post.published.sorted
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def show
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :blurb, :cover_image, :content, :published_at)
  end

  def set_post
    @post = 
      if user_signed_in? 
        Post.find(params[:id])
      else 
        Post.published.find(params[:id])
      end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end