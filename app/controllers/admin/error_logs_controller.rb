class Admin::ErrorLogsController < Admin::BaseController
  def index
    @per_page=(params[:per_page] || 10).to_i
    @error_logs = ErrorLog.recent.page(params[:page]).per(@per_page)
  end

  def destroy
    @error_log = ErrorLog.find(params[:id])
    @error_log.destroy
    redirect_to admin_error_logs_path, notice: "Error Log cleared"
  end
end
