class BlogsController < BaseController

  def index
    @blogs = Blog.all.page(params[:page]).per(5)
    @blogs  = Blog.where('title like ?', "%#{params[:search]}%").page(params[:page]).per(5) if params[:search].present?
    respond_to do |format|
      format.html
      format.js
    end
  end



end
