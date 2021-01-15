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
      number = row[0].strip
      load_monitor(number)
      return unless @monitor

      return if row[9].blank?

      @info = @monitor.infos.find_or_create_by(recorded_at: row[9].strip)
      @info.cod = row[1].to_f
      @info.do = row[2].to_f
      @info.tp = row[3].to_f
      @info.nh3 = row[4].to_f
      @info.ss = row[5].to_f
      @info.ph = row[6].to_f
      @info.v = row[7].to_f
      @info.q = row[8].to_f

      @info.save

      puts @info

      puts '--------------' + @info.id.to_s
    end

    def load_monitor(number)
      @monitor = find_by(number: number)
    end
  end
end
