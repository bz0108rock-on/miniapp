class BlogsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
    @articles = Article.all.order("id DESC").page(params[:page]).per(5)
  end

  def new
  end

  def create
    Article.create(title: blog_params[:title], image: blog_params[:image], content: blog_params[:content], user_id: current_user.id)
  end

  def destroy
    article = Article.find(params[:id])
      article.destroy if article.user_id === current_user.id
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id])
      if article.user_id == current_user.id
        article.update(blog_params)
      end
  end

  private
  def blog_params
    params.permit(:title, :image, :content)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end