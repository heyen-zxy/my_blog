class BlogsController < BaseController

  def index
    @blogs  = Blog.where(Blog.get_conditions params).page(params[:page]).per(5)
    respond_to do |format|
      format.html
      format.js
    end
  end


end
