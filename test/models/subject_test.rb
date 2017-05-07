require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  def setup
    @subject = Subject.new(code: '888', name: '科目名', short_name: '科')
  end

  test 'name should be unique' do
    @subject.name = Subject.first.name
    assert_not@subject.valid?
  end

  test 'name should be present' do
    @subject.name = '  '
    assert_not @subject.valid?
  end

  test 'code should be unique' do
    @subject.code = Subject.first.code
    assert_not @subject.valid?
  end

  test 'code should be present' do
    @subject.code= '  '
    assert_not @subject.valid?
  end

  test 'code validation should reject invalid codes' do
    invalid_codes = %w"aaa 01 99 1 1234"
    invalid_codes.each do |code|
      @subject.code= code
      assert_not @subject.valid?
    end
  end
end
