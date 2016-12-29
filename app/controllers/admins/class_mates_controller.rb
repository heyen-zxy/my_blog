class Admins::ClassMatesController < Admins::BaseController
  def index
    @class_mates = ClassMate.order('created_at desc').page(params[:page]).per(15)
    respond_to do |format|
      format.html
      format.js
    end
  end
end
