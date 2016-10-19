class Admins::TagsController < Admins::BaseController
  before_action :set_tag, only: [:update, :destroy]
  def index
    @tags = Tag.all.order('created_at desc')
    @tag = Tag.new
  end

  def create
    @tag = Tag.new
    if @tag.update tag_params
      flash[:notice] = '添加成功'
    else
      flash[:error] = '添加失败'
    end
    redirect_to admins_tags_path
  end

  def destroy
    if @tag.destroy
      flash[:notice] = '删除成功'
    else
      flash[:error] = '删除失败'
    end
    redirect_to admins_tags_path

  end

  def update
    if @tag.update tag_params
      flash[:notice] = '修改成功'
    else
      flash[:error] = '修改失败'
    end
    redirect_to admins_tags_path
  end

  private
  def set_tag
    begin
      @tag= Tag.find params[:id]
    rescue => e
      flash[:error] = '找不到数据'
      redirect_to admins_tags_path
    end

  end

  def tag_params
    params.require(:tag).permit(:name)
  end

end

