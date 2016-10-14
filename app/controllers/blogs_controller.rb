class BlogsController < BaseController

  before_action :set_blog, only: [:show]
  def index
    @blogs  = Blog.includes(:tags).where(Blog.get_conditions params).page(params[:page]).per(5)
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
    @contact = Contact.new
  end


  def send_message
    @contact = Contact.create contact_params
    redirect_to contact_blogs_path, notice: '谢谢您的关注,我会尽快回复您!'
  end





  private
  def set_blog
    begin
      @blog = Blog.find_by_id params[:id]
    rescue => e
      redirect_to blogs_path
    end

  end

  def contact_params
    params.require(:contact).permit(:name, :tel, :email, :message)
  end





end
