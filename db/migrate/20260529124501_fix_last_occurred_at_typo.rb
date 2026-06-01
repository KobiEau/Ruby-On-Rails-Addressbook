class FixLastOccurredAtTypo < ActiveRecord::Migration[8.1]
  def change
    rename_column :error_logs, :last_occured_at, :last_occurred_at
  end
end
