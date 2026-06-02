class ErrorLogger
    LOG_PATH = Rails.root.join("log", "errors.ndjson")

    def self.log(exception, request, current_user)
      new(exception, request, current_user).log
    end

    def initialize(exception, request, current_user)
       @exception = exception
       @request = request
       @current_user = current_user 
       ensure_log_file_exists
    end
    
    
    def log
      record=write_to_database
      write_to_json
      record
    end

    private
    def ensure_log_file_exists
      FileUtils.touch(LOG_PATH) unless File.exist?(LOG_PATH)
    end

    def write_to_database
      existing = ErrorLog.find_by(
        error_class: @exception.class.to_s,
        path: @request.path,
        http_method: @request.method
      )

      if existing 
        existing.update(
          occurrences: existing.occurrences + 1,
          last_occurred_at: Time.current,
          backtrace: filtered_backtrace
        )
        existing #returns the record
      else
        ErrorLog.create(
          error_class: @exception.class.to_s,
          message:  @exception.message.truncate(500),
          path: @request.path,
          http_method: @request.method,
          user_id: @current_user&.id,
          ip_address: @request.remote_ip,
          occurrences: 1,
          last_occurred_at: Time.current,
          backtrace: filtered_backtrace
        )
        #Errorlog.create returns record automatically
      end
      
    end

    def write_to_json
      entry ={
        timestamp: Time.current.iso8601,
        error_class: @exception.class.to_s,
        message: @exception.message.truncate(500),
        path: @request.path,
        http_method: @request.method,
        user_id: @current_user&.id,
        ip_address: @request.remote_ip
      }

      File.open(LOG_PATH, "a") do |f|
        f.flock(File::Constants::LOCK_EX)
        f.puts(entry.to_json)
        f.flock(File::LOCK_UN)
      end
    rescue => e
      Rails.logger.error("ErrorLogger JSON write failed: #{e.message}")
    end

    def filtered_backtrace
      return [] if @exception.backtrace.nil?

      @exception.backtrace.select do |line|
        line.include?(Rails.root.to_s)
      end
    end
end