class ScoresScraper
  def initialize
    @uri = 'http://www.fifa.com/worldcup/matches/index.html'
  end

  def request
    Nokogiri::HTML(open(@uri))
  end

  def pulled_data
    self.request.css('.col-xs-3 div')
  end

  def match_array
    arr = [ ]
    self.pulled_data.each do |match|
        arr << {
                  date: match.children.css('.mu-i-datetime').text,
                  home_team: match.children.css('.t.home span.t-nTri').text,
                  away_team: match.children.css('.t.away span.t-nTri').text,
                  score: match.children.css('.s span.s-scoreText').text
                }
    end
    arr.select{|item| item unless item[:date].empty? || item[:home_team].empty?}
  end

  def not_present?(match_date)
    match_date.empty?
  end

end