class ScoresScraper
  def initialize
    @uri = 'http://www.fifa.com/worldcup/matches/index.html'
  end

  def request
    Nokogiri::HTML(open(@uri))
  end

  def pulled_data
    self.request.css('.match-list-date.anchor .col-xs-12 div')
  end

  def match_array
    arr = [ ]
    self.pulled_data.each do |match|
      arr << {
                date: convert_to_datetime(match.children.css('.mu-i-datetime').text),
                home_team: match.children.css('.t.home span.t-nTri').text,
                away_team: match.children.css('.t.away span.t-nTri').text,
                score: match.children.css('.s span.s-scoreText').text,
                status: match.children.css('.s .s-status').text
              }
    end
    clean_arr = clean_array(arr)
    { yesterday: yesterday_matches(clean_arr), today: today_matches(clean_arr), tomorrow: tomorrow_matches(clean_arr) }
  end

  def clean_array(arr)
    arr.select{|item| item unless invalid_match?(item)}
  end

  def yesterday_matches(arr)
    arr.select{|s| s if s[:date].to_date == Date.today - 1}
  end

  def today_matches(arr)
    arr.select{|s| s if s[:date].to_date == Date.today}
  end

  def tomorrow_matches(arr)
    arr.select{|s| s if s[:date].to_date == Date.today + 1}
  end

  def convert_to_datetime(string)
    DateTime.strptime(string, '%d %b %Y - %H:%M') unless string.empty?
  end

  def invalid_match?(item)
    item[:date].class != DateTime || item[:home_team].empty?
  end

end