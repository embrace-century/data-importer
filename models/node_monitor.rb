require 'csv'

class NodeMonitor < BaseRecord
  self.table_name = 'node_monitors'

  has_many :infos, foreign_key: 'monitor_id', class_name: 'MonitorInfo'

  class << self
    def load_csv
      CSV.foreach('/Users/zyc/Developer/hanqiu/data-importer/2021-01-14.csv') { |row| handle_row row }
    end

    def clean_database
      find_each do |record|
        record.number = record.number.strip
        puts record.number
        record.save
      end
    end

    def handle_row(row)
      load_monitor(row[0])
    end

    def load_monitor(number)
      puts number.strip
    end
  end
end
