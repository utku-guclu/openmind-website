class PostsController < ApplicationController
  def index
    @posts = Post.published.recent
    @posts = @posts.where(category: params[:category]) if params[:category].present?
  end

  def show
    @post = Post.published.find_by!(slug: params[:slug])
    @related_posts = Post.published.where.not(id: @post.id).where(category: @post.category).recent.limit(3)
  end
end
