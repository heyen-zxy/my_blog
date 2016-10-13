class BlogsController < BaseController

  before_action :set_blog, only: [:show]
  def index
    @blogs  = Blog.where(Blog.get_conditions params).page(params[:page]).per(5)
    respond_to do |format|
      format.html
      format.js
    end
  end


  def show
  end

  def about

  end

  def contact

  end





  private
  def set_blog
    begin
      @blog = Blog.find_by_id params[:id]
    rescue => e
      redirect_to blogs_path
    end

  end





end
