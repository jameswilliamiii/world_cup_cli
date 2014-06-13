class Scores
  class << self
    def updated_at
      Time.now.strftime('%D %T')
    end

    def latest_updates
      puts "\n\nScores and upcoming matches updated as of #{Scores.updated_at}".colorize(:yellow)
      scores = ScoresScraper.new.match_array
      puts "Yesterday's results".colorize(:light_blue) unless scores[:yesterday].empty?
      display_results(scores[:yesterday])
      puts "\n"
      puts "Today's matches and results".colorize(:light_blue) unless scores[:today].empty?
      display_results(scores[:today])
      puts "\n"
      puts "Tomorrow's upcoming matches".colorize(:light_blue) unless scores[:tomorrow].empty?
      display_results(scores[:tomorrow])
      return
    end

    def display_results(arr)
      arr.each do |match|
        display_match(match)
      end
    end

    def display_match(match)
      puts "#{match[:home_team]}  #{match[:score]}  #{match[:away_team]}   #{match_status(match)}"
    end

    def match_status(match)
      "Status: #{match[:status]}" unless match[:status].strip.empty?
    end
  end
end