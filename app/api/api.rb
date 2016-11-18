class API < Grape::API
  helpers do
    def logger
      Logger.new('log/api.log')
    end
  end

  desc "测试接口"
  post :test  do
    logger.info params
    status 200
    env['api.format'] = :txt
    "0"
  end
end

