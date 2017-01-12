class API < Grape::API
  helpers do
    def logger
      Logger.new('log/api.log')
    end
  end

  get :test  do
    logger.info '---get api-'
    logger.info params
    status 200
  end

  desc "测试接口"
  post :test  do
    logger.info '----post api-----'
    logger.info params
    logger.info '------key-----'
    logger.info params.key(nil)
    reports = JSON.parse params.key(nil)
    unless reports.is_a?(Array)
      arr = []
      arr << reports
      reports = arr
    end
    reports.each do |report|
      logger.info report['msgId'], report['result']
    end

    status 200
    {flag: 200, desc: "OK"}
  end
end

