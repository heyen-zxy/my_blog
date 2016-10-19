class BaseController < ApplicationController

  before_action 'sum_access'

  def sum_access
    access = Access.find_or_create_by(blog_id: nil)
    access.update amount: (access.amount + 1)
  end

end
