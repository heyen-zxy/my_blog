class Admins::CategoriesController < Admins::BaseController
  before_action :set_category, only: [:update, :destroy]
  def index
    @categories = Category.all.order('created_at desc')
    @category = Category.new
  end

  def create
    @category = Category.new
    if @category.update category_params
      flash[:notice] = '添加成功'
    else
      flash[:error] = '添加失败'
    end
    redirect_to admins_categories_path
  end

  def destroy
    if @category.blogs.present?
      flash[:error] = '该分类下还有博客'
    else
      if @category.destroy
        flash[:notice] = '删除成功'
      else
        flash[:error] = '删除失败'
      end
    end
    redirect_to admins_categories_path

  end

  def update
    if @category.update category_params
      flash[:notice] = '修改成功'
    else
      flash[:error] = '修改失败'
    end
    redirect_to admins_categories_path
  end

  private
  def set_category
    begin
      @category = Category.find params[:id]
    rescue => e
      flash[:error] = '找不到数据'
      redirect_to admins_categories_path
    end

  end

  def category_params
    params.require(:category).permit(:name)
  end

end
