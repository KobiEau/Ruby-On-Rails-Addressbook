class CleanupErrorLogsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Delete error logs older than 30 days
    deleted_count = ErrorLog.where("created_at < ?", 30.days.ago).delete_all

    # Log how many were deleted to have a record
    Rails.logger.info("CleanupErrorLogsJob: deleted #{deleted_count} old error log(s)")
  end
end
