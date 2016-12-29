class ClassMatesController < ApplicationController
  layout 'mates'
  before_action :set_class_mate, only: [:update, :destroy]
  def meet

  end

  def index
    @class_mates = ClassMate.all.order('created_at desc')
    @class_mate = ClassMate.new
  end

  def create
    @class_mate = ClassMate.new
    if @class_mate.update class_mate_params
      flash[:notice] = '添加成功'
    else
      flash[:error] = '添加失败'
    end
    redirect_to class_mates_path
  end

  def destroy
    if @class_mate.destroy
      flash[:notice] = '删除成功'
    else
      flash[:error] = '删除失败'
    end
    redirect_to class_mates_path

  end

  def update
    if @class_mate.update class_mate_params
      flash[:notice] = '修改成功'
    else
      flash[:error] = '修改失败'
    end
    redirect_to class_mates_path
  end

  private
  def set_class_mate
    begin
      @class_mate = ClassMate.find params[:id]
    rescue => e
      flash[:error] = '找不到数据'
      redirect_to class_mates_path
    end

  end

  def class_mate_params
    params.require(:class_mate).permit(:name, :tel, :number)
  end

end
