module Admin::BaseHelper

  def side_style side_name, params
    'active' if side_name.downcase == params[:controller].downcase
  end


end