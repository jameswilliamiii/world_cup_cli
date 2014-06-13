require 'test/unit'
require 'scores'
require 'date'

class TestScores < Test::Unit::TestCase
  def test_display_match
    match = { date: DateTime.now, home_team: "BRA", away_team: "CRO", score: "3-1", status: "Full-time" }
    actual = Scores.display_match(match)
    expected = "BRA  3-1  CRO   Status: Full-time"
    assert_equal actual, expected
  end

  def test_match_status
    match = { date: DateTime.now, home_team: "BRA", away_team: "CRO", score: "3-1", status: " " }
    expected = nil
    actual = Scores.match_status(match)
    assert_equal actual, expected
  end

  def test_updated_at
    time = Time.now
    expected = time.strftime('%D %T')
    actual = Scores.updated_at
    assert_equal actual, expected
  end
end