require 'test_helper'

class JurisdictionTest < ActiveSupport::TestCase
  def setup
    @jurisdiction = Jurisdiction.new(name: 'テスト', roman: 'tesuto')
  end

  test 'name should be unique' do
    @jurisdiction.name = Jurisdiction.first.name
    assert_not @jurisdiction.valid?
  end

  test 'name should be present' do
    @jurisdiction.name= '  '
    assert_not @jurisdiction.valid?
  end

  test 'roman should be unique' do
    @jurisdiction.roman = Jurisdiction.first.roman
    assert_not @jurisdiction.valid?
  end

  test 'roman should be present' do
    @jurisdiction.roman= '  '
    assert_not @jurisdiction.valid?
  end

  test 'code validation should reject invalid romans' do
    invalid_romans = %w"ひらがな カタカナ ﾊﾝｶﾅ 1"
    invalid_romans.each do |roman|
      @jurisdiction.roman= roman
      assert_not @jurisdiction.valid?
    end
  end
end
