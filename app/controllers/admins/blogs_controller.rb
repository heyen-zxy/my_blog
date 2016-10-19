class Admins::BlogsController < Admins::BaseController
  include ApplicationHelper
  before_action :set_blog, only: [:edit, :update, :destroy]

  def index
    @blogs = Blog.includes(:category, :tags, :access).order('created_at desc').page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new
    if @blog.update blog_params
      flash[:notice] = '添加成功'
    else
      flash[:error] = '添加失败'
    end
    redirect_to admins_blogs_path
  end

  def edit

  end

  def update
    if @blog.update blog_params
      flash[:notice] = '修改成功'
    else
      flash[:error] = '修改失败'
    end
    redirect_to admins_blogs_path
  end

  def destroy
    if @blog.destroy
      flash[:notice] = '删除成功'
    else
      flash[:error] = '删除失败'
    end
    redirect_to admins_blogs_path
  end

  def view
    @content = markdown params[:content]
    respond_to do |format|
      format.js
    end
  end


  private

  def set_blog
    begin
      @blog = Blog.find params[:id]
    rescue => e
      flash[:error] = '找不到数据'
      redirect_to admins_blogs_path
    end
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :category_id, tag_ids: [])
  end


end
