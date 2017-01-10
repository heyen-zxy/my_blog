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
    begin
      reports = JSON.parse params.key(nil)
      logger.info reports
      if reports.is_a? Array
        reports.each do |report|
          logger.info report
          logger.info report['mobile']
        end
      else
        logger.info reporst['msgId']
      end

    rescue => e
      logger.info e
    end

    status 200
    {flag: 200, desc: "OK"}
  end
end

