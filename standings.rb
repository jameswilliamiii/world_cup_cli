class Standings
  def self.header
    "Country     W     D     L     GF     GA     Pts" # 47 chars
  end

  def self.updated_at
    Time.now.strftime('%D %T')
  end

  def self.latest_updates
      puts "\n\nStandings as of #{Standings.updated_at}"
      GroupData.new.groups_hash.each do |group|
        puts "\n                    #{group[:name]}                    "
        puts Standings.header
        group[:countries].each do |country|
          puts "#{country[:name]}         #{country[:wins]}     #{country[:draws]}     #{country[:losses]}     #{country[:goals_for]}      #{country[:goals_against]}      #{country[:points]}"
        end
      end
      puts "\n"
  end
end