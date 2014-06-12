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
    clean_array = arr.select{|item| item unless invalid_match?(item)}
    yesterday = clean_array.select{|s| s if s[:date].to_date == Date.today - 1}
    today = clean_array.select{|s| s if s[:date].to_date == Date.today}
    tomorrow = clean_array.select{|s| s if s[:date].to_date == Date.today + 1}
    { yesterday: yesterday, today: today, tomorrow: tomorrow }
  end

  def convert_to_datetime(string)
    DateTime.strptime(string, '%d %b %Y - %H:%M') unless string.empty?
  end

  def invalid_match?(item)
    item[:date].class != DateTime || item[:home_team].empty?
  end

end