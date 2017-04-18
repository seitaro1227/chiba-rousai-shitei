require 'test_helper'

class StationTest < ActiveSupport::TestCase
  def setup
    @station = Station.new(name: '駅名')
  end

  test 'name should be unique' do
    @station.name = Station.first.name
    assert_not @station.valid?
  end

  test 'name should be present' do
    @station.name = '  '
    assert_not @station.valid?
  end
end
