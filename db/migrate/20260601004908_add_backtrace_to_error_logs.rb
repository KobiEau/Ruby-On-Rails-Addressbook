class AddBacktraceToErrorLogs < ActiveRecord::Migration[8.1]
  def change
    add_column :error_logs, :backtrace, :text, array: true, default: []
  end
end
