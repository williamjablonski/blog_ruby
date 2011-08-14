class PostsController < ApplicationController

  expose(:page)   { Page.find_by_permalink('home') }
  expose(:posts)  { Post.active.by_date(params[:year], params[:month], params[:day]) }
  expose(:resource)      { User.new }
  expose(:resource_name) { :user }
  expose(:post)   do
    if current_user && current_user.has_access_to?(:admin)
      Post.find_by_permalink(params[:id])
    else
      Post.active.find_by_permalink(params[:id])
    end
  end
  expose(:recent) do
    if current_user && current_user.has_access_to?(:admin)
      Post.recent
    else
      Post.active.recent
    end
  end

  def index
  end

  def show
    @comment = Comment.new
  end

  def by_date
    @page = page
    @page.page_title = t(:page_title, scope: [:posts_by_date], date: meta_date)
    @page.page_body  = t(:page_body,  scope: [:posts_by_date], date: meta_date)
  end

  private

  def meta_date
    dates = Post.time_interval(params[:year],params[:month], params[:day]).map(&:to_date)
    "#{l(dates.first)} - #{l(dates.last)}"
  end

end
