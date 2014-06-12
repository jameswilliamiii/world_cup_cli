Gem::Specification.new do |s|
  s.name        = 'world_cup_cli'
  s.version     = '0.0.4'
  s.date        = '2014-06-12'
  s.summary     = "world cup 2014 tables and scores"
  s.description = "A command line interface to quickly check table standings, scores, and upcoming matches for the World Cup"
  s.authors     = ["James Stubblefield"]
  s.email       = 'jameswilliamiii@gmail.com'
  s.files       = Dir["{config}/*", "{lib}/*"]
  s.executables << 'world_cup_cli'
  s.homepage    =
    'https://github.com/jameswilliamiii/world_cup_cli'
  s.license       = 'MIT'
  s.add_runtime_dependency 'nokogiri', [">=1.6.2"]
  s.add_runtime_dependency 'colorize', [">=0.7.3"]
end