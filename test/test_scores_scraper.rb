require 'test/unit'
require 'scores_scraper'

class TestScoresScraper < Test::Unit::TestCase

  def dirty_array
    [
      { date: ScoresScraper.new.convert_to_datetime("12 June 2014 - 17:00"), home_team: "BRA", away_team: "CRO", score: "3-1", status: "Full-time" },
      { date: "12 June 2014 - 17:00", home_team: "",    away_team: "CRO", score: "3-1", status: "Full-time" },
      { date: "12 June 2014 - 17:00", home_team: "BRA", away_team: "CRO", score: "3-1", status: "Full-time" }
    ]
  end

  def match_array
    [
      { date: (Date.today - 1), home_team: "BRA", away_team: "CRO", score: "3-1", status: "Full-time" },
      { date: Date.today, home_team: "BRA", away_team: "CRO", score: "3-1", status: "Full-time" },
      { date: (Date.today + 1), home_team: "BRA", away_team: "CRO", score: "3-1", status: "Full-time" }
    ]
  end

  def test_convert_to_datetime
    date_string = "12 June 2014 - 17:00"
    expected = DateTime.strptime(date_string, '%d %b %Y - %H:%M')
    actual = ScoresScraper.new.convert_to_datetime(date_string)
    assert_equal expected, actual
  end

  def test_clean_array
    expected = [ dirty_array.first ]
    actual = ScoresScraper.new.clean_array(dirty_array)
    assert_equal expected, actual
  end

  def test_yesterday_matches
    expected = [ { date: Date.today - 1, home_team: "BRA", away_team: "CRO", score: "3-1", status: "Full-time" } ]
    actual = ScoresScraper.new.yesterday_matches(match_array)
    assert_equal expected, actual
  end

  def test_today_matches
    expected = [ { date: Date.today, home_team: "BRA", away_team: "CRO", score: "3-1", status: "Full-time" } ]
    actual = ScoresScraper.new.today_matches(match_array)
    assert_equal expected, actual
  end

  def test_tomorrow_matches
    expected = [ { date: Date.today + 1, home_team: "BRA", away_team: "CRO", score: "3-1", status: "Full-time" } ]
    actual = ScoresScraper.new.tomorrow_matches(match_array)
    assert_equal expected, actual
  end
end