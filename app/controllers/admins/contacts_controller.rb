class Admins::ContactsController < Admins::BaseController
  before_action :set_contact, only: [:destroy]
  def index
    @contacts = Contact.order('created_at desc').page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    if @contact.destroy
      flash[:notice] = '删除成功'
    else
      flash[:error] = '删除失败'
    end
    redirect_to admins_contacts_path
  end

  private

  def set_contact
    begin
      @contact = Contact.find params[:id]
    rescue => e
      flash[:error] = '找不到数据'
      redirect_to admins_contacts_path
    end
  end


end
