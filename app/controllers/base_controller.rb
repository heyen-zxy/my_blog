class BaseController < ApplicationController
  before_action :log_elk

  def log_elk
    hash = {
        timestamp: DateTime.now,
        type: rand(10)%2,
        code: rand(99999999).to_s
    }
    LoggerToJson.logstash 'test', hash
  end

end
