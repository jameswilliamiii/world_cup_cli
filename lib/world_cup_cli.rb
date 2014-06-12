#!/usr/bin/env ruby
require_relative '../config/environment.rb'

banner = "* World Cup CLI: Quickly check table standings and scores *"

opt_parser = OptionParser.new do |opt|
  opt.banner =   ("\n" + "*" * banner.length + "\n" + banner + "\n" + "*" * banner.length).colorize(:light_blue)
  opt.separator  "Commands".colorize(:red)
  opt.separator  "   standings: See latest group table standings".colorize(:red)
  opt.separator  "   scores: See scores and upcoming matches".colorize(:red)
  opt.separator  ""
  opt.separator  "Usage example: world_cup_cli standings"
end

opt_parser.parse!

case ARGV[0]
when "standings"
  puts Standings.latest_updates
when "scores"
  puts Scores.latest_updates
else
  puts opt_parser
end