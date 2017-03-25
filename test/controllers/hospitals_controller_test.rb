require 'test_helper'

class HospitalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hospitals_url
    assert_response :success
  end

  test "location_params brank input" do
    hospital_controller = HospitalsController.new
    current_location_param = ''
    params = hospital_controller.send(:location_params, current_location_param)
    assert_not_nil params
    assert_empty params[:lat]
    assert_empty params[:lng]
    assert_not params[:result]
  end

  test "location_params correct input" do
    hospital_controller = HospitalsController.new
    current_location_param = '35.7857613,139.8994325'
    params = hospital_controller.send(:location_params, current_location_param)
    assert_not_nil params
    assert_equal '35.7857613',params[:lat]
    assert_equal '139.8994325',params[:lng]
    assert params[:result]
  end

  test "search_hospital brank_param" do
    hospitals_controller = HospitalsController.new
    params = {current_location: '', km: '', subject: '', name: ''}
    jurisdiction = Jurisdiction.find_by(roman: '')
    hospitals = hospitals_controller.send(:search_hospital, params, jurisdiction)
    exp = Hospital.all
    assert_equal exp.count,hospitals.count
    assert_equal exp.to_sql, hospitals.to_sql
  end

  test "search_hospital jurisdiction is chiba" do
    hospitals_controller = HospitalsController.new
    params = {current_location: '', km: '', subject: '', name: ''}
    jurisdiction = Jurisdiction.find_by(roman: 'chiba')
    hospitals = hospitals_controller.send(:search_hospital, params, jurisdiction)
    exp = jurisdiction.hospitals
    assert_equal exp.count,hospitals.count
    # assert_equal exp.to_sql, hospitals.to_sql
  end

  test "search_hospital all params" do
    hospitals_controller = HospitalsController.new
    params = {current_location: '35.7857613,139.8994325', km: '1', subject: '歯', name: '歯'}
    jurisdiction = Jurisdiction.find_by(roman: 'chiba')
    hospitals = hospitals_controller.send(:search_hospital, params, jurisdiction)
    exp = Hospital
              .within(params[:km].to_i ,origin: ['35.7857613', '139.8994325'])
              .where('subject LIKE ?', "%#{params[:subject]}%")
              .where('name LIKE ?', "%#{params[:name]}%")
              .where('jurisdiction_id = ?', jurisdiction.id)
    assert_equal exp.count,hospitals.count
    assert_equal exp.to_sql, hospitals.to_sql
  end
end
