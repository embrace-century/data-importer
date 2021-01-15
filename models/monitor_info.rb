class MonitorInfo < BaseRecord
  self.table_name = 'monitor_infos'

  belongs_to :monitor, foreign_key: 'monitor_id', class_name: 'NodeMonitor'
end
