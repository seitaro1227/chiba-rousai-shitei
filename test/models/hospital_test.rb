require 'test_helper'

class HospitalTest < ActiveSupport::TestCase
  def setup
    @hospital = Hospital.new(number: '8888888', name: '病院名', address: '住所', zip_code: '111-1111')
  end

  test 'number should be unique' do
    dup = Hospital.first.dup
    assert_not dup.valid?
  end

  test 'number should be present' do
    @hospital.number = '   '
    assert_not @hospital.valid?
  end

  test 'name should be present' do
    @hospital.name = '   '
    assert_not @hospital.valid?
  end

  test 'address should be present' do
    @hospital.address = '   '
    assert_not @hospital.valid?
  end

  test 'zip_code should be present' do
    @hospital.zip_code = '   '
    assert_not @hospital.valid?
  end
end
