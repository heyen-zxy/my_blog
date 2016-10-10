class BlogsController < BaseController

  def index
    @blogs = Blog.all.page(params[:page]).per(5)
    respond_to do |format|
      format.html
      format.js
    end
  end


  def search_blogs
    
  end

end
