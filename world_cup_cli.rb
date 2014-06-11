require 'nokogiri'
require 'open-uri'

class Search
  def initialize(uri)
    @doc = Nokogiri::HTML(open(uri))
  end

  def page
    @doc
  end
end

class Tables
  def initialize
    @page = Search.new('http://www.fifa.com/worldcup/groups/index.html').page
  end

  def table_header
    "Teams     W     D     L     GF     GA     Pts"
  end
end