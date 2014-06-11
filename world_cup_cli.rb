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