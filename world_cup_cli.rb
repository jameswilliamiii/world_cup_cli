require 'nokogiri'
require 'open-uri'

class GroupData
  def initialize
    @uri = 'http://www.fifa.com/worldcup/groups/index.html'
  end

  def request
    Nokogiri::HTML(open(@uri))
  end

  def pulled_data
    self.request.css('.group-wrap')
  end

  def groups_hash
    arr = [ ]
    self.pulled_data.each do |group|
      arr << {
                name: group.css('.caption-nolink').text,
                countries: countries_hash(group.css('tr'))
              }
    end
    return arr
  end

  def countries_hash(countries)
    arr = [ ]
    countries.each do |country|
      unless not_present?(country.css('.tbl-teamcode .t-nTri').text)
        arr << {
                  name: country.css('.tbl-teamcode .t-nTri').text,
                  wins: country.css('.tbl-win span.text').text,
                  draws: country.css('.tbl-draw span.text').text,
                  losses: country.css('.tbl-lost span.text').text,
                  goals_for: country.css('.tbl-goalfor span.text').text,
                  goals_against: country.css('.tbl-goalagainst span.text').text,
                  points: country.css('.tbl-pts span.text').text
                }
      end
    end
    return arr
  end

  def not_present?(country_name)
    country_name.empty?
  end
end

class Table
  def self.header
    "Country     W     D     L     GF     GA     Pts" # 47 chars
  end

  def self.updated_at
    Time.now.strftime('%D %T')
  end

  def self.groups
      puts "Standings as of #{Table.updated_at}"
      GroupData.new.groups_hash.each do |group|
        puts "                    #{group[:name]}                    "
        puts Table.header
        group[:countries].each do |country|
          puts "#{country[:name]}         #{country[:wins]}     #{country[:draws]}     #{country[:losses]}     #{country[:goals_for]}      #{country[:goals_against]}      #{country[:points]}"
        end
        puts "\n"
      end
  end
end