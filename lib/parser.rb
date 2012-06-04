require 'mechanize'

class Parser
  URL      = "http://www2.des.state.nh.us/rti_data/OSLNH_TABLE.HTML"
  SELECTOR = "div.report > table tr"

  def initialize
    @agent = Mechanize.new
    @table = @agent.get(URL).search(SELECTOR)
  end

  def lake_elevation
    output     = []
    dates      = []
    elevations = []

    @table.each do |row|
      dates << row.search('td:first-child').inner_text
      elevations << row.search('td:nth-child(2)').inner_text
    end

    dates.each_with_index do |date, index|
      hash = {
        "date"  => date,
        "value" => elevations[index]
      }

      output << hash
    end

    return output
  end
end
