class API < Grape::API
  helpers do
    def logger
      Logger.new('log/api.log')
    end
  end

  get :test  do
    logger.info params
    status 200
  end

  desc "测试接口"
  post :test  do
    logger.info params
    status 200
    {flag: 200, desc: "OK"}
  end
end

