class Scores
  def self.updated_at
    Time.now.strftime('%D %T')
  end

  def self.latest_updates
    puts "\n\nScores and upcoming matches updated as of #{Scores.updated_at}"
    ScoresScraper.new.match_array.each do |match|
      puts "\n#{match[:date]}                    "
      puts "#{match[:home_team]}  #{match[:score]}  #{match[:away_team]}"
    end
    puts "\n"
  end
end