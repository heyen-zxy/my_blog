class LoggerToJson
  class << self
    #elk日志

    def logger_json record, columns
      hash = {:timestamp => DateTime.now}
      columns.each do |column|
        hash[column] = record.send(column.to_sym)
      end
      hash.to_json
    end

    def record_logger log_name
      logger = Logger.new get_log_path(log_name)
      # message为已格式化的json文本
      logger.formatter = proc {|severity, timestamp, progname, message| "#{message}\n"}
      logger
    end

    def get_log_path log_name
      "log/#{log_name}.log"
    end

    def logstash log_name, hash
      record_logger(log_name).info hash.to_json
    end

  end

end