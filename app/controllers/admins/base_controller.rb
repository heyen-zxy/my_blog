class Admins::BaseController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin_application'

end
