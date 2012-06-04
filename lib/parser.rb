require 'mechanize'

class Parser
  URL      = "http://www2.des.state.nh.us/rti_data/OSLNH_TABLE.HTML"
  SELECTOR = "div.report > table tr"

  def initialize
    @agent = Mechanize.new
    @table = @agent.get(URL).search(SELECTOR)
  end

  def lake_elevation
    output = []

    get_dates.each_with_index do |date, index|
      hash = {
        "date"  => date,
        "value" => get_lake_elevation[index]
      }

      output << hash
    end

    return output
  end


  private

  def get_dates
    dates = []
    @table.each do |row|
      dates << row.search('td:first-child').inner_text
    end

    return dates
  end

  def get_lake_elevation
    lake_elevation_data = []

    @table.each do |row|
      lake_elevation_data << row.search('td:nth-child(2)').inner_text
    end
    return lake_elevation_data
  end
end
