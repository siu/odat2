require 'test_helper'

class OdatDiagnosesControllerTest < ActionController::TestCase
  include NotLoggedInChecks

  def test_should_get_index
    login_as_user
    get :index, :medical_record_id => medical_records(:pedrito).id
    assert_response :success
    assert_not_nil assigns(:odat_diagnoses)
    assert_equal medical_records(:pedrito).odat_diagnoses.size, 
	    assigns(:odat_diagnoses).size
  end

  test "should not get index if user is not in the same center as the record" do
    login_as :demo
    get :index, :medical_record_id => medical_records(:paco).id
    assert_redirected_to medical_records_path
  end

  def test_should_get_new
    login_as_user
    get :new, :medical_record_id => medical_records(:pedrito).id
    assert_response :success
  end

  def test_should_create_odat_diagnosis
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
    assert_difference('OdatDiagnosis.count') do
      post :create, 
	:medical_record_id => medical_records(:pedrito).id, 
	:odat_diagnosis => { 
          :origin_source_id => origin_sources(:one).id, 
          :origin_cause_id => origin_causes(:one).id, 
          :consultation_cause_id => consultation_causes(:one).id, 
          :main_diagnosis_item_id => diagnosis_items(:e1_1_1).id, 
        }
    end

    assert_redirected_to 
    	medical_record_odat_diagnoses_path(
	  {:medical_record_id => medical_records(:pedrito).id}, 
	  assigns(:medical_record))
  end

  test "should not create if user is not in the same center as the record" do
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
    assert_no_difference('OdatDiagnosis.count') do
      post :create, 
	:medical_record_id => medical_records(:paco).id, 
	:odat_diagnosis => { 
          :origin_source_id => origin_sources(:one).id, 
          :origin_cause_id => origin_causes(:one).id, 
          :consultation_cause_id => consultation_causes(:one).id, 
          :main_diagnosis_item_id => diagnosis_items(:e1_1_1).id, 
        }
    end
    assert_redirected_to medical_records_path
  end

  test "should allow creation of two odat_diagnosis with the same medical_record" do
    login_as_user

    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)

    items = get_diagnosis_items_ids([:e1_1_1, :e1_1_2])

    2.times do
      assert_difference('OdatDiagnosis.count') do
        post :create, 
          {
            :medical_record_id => medical_records(:pedrito).id, 
            :odat_diagnosis => { 
              :origin_source_id => origin_sources(:one).id, 
              :origin_cause_id => origin_causes(:one).id, 
              :consultation_cause_id => consultation_causes(:one).id, 
              :main_diagnosis_item_id => diagnosis_items(:e1_1_1).id, 
              :diagnosis_item_ids => items
            }
          }
      end
      assert_response :redirect
      assert !assigns(:odat_diagnosis).new_record?
      assert_equal items.size, assigns(:odat_diagnosis).diagnosis_items.size
    end
  end

  def test_should_show_odat_diagnosis
    login_as_user
    get :show, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id
    assert_response :success
  end

  test "should not show if user not in the same center" do
    login_as :demo
    get :show, 
	:medical_record_id => medical_records(:paco).id, 
	:id => odat_diagnoses(:one).id
    assert_redirected_to medical_records_path
  end

  def test_should_get_edit
    login_as_user
    get :edit, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id
    assert_response :success
  end

  test "should not get edit if user not in the same center" do
    login_as :demo
    get :edit, 
	:medical_record_id => medical_records(:paco).id, 
	:id => odat_diagnoses(:one).id
    assert_redirected_to medical_records_path
  end

  def test_should_update_odat_diagnosis
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
    put :update, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id, 
	:odat_diagnosis => { }
    assert_redirected_to(
    	medical_record_odat_diagnoses_path(
	    :medical_record_id => medical_records(:pedrito).id))
  end

  test "should not update if user not in the same center" do
    login_as :demo
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
    put :update, 
        { :medical_record_id => medical_records(:paco).id, 
	  :id => odat_diagnoses(:one).id, 
	  :odat_diagnosis => { }
        }
    assert_redirected_to medical_records_path
  end
  
  test "should update item_diagnosis relations" do
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)

    items = get_diagnosis_items_ids([:e1_1_1, :e1_1_2])
    put :update, 
        { :medical_record_id => medical_records(:pedrito).id, 
    	  :id => odat_diagnoses(:one).id, 
	  :odat_diagnosis => { :diagnosis_item_ids => items }
        }

    assert_response :redirect
    assert_equal items.size, assigns(:odat_diagnosis).diagnosis_items.size

    items = []
    put :update, 
        { :medical_record_id => medical_records(:pedrito).id, 
	  :id => odat_diagnoses(:one).id, 
	  :odat_diagnosis => { :diagnosis_item_ids => items }
        }

    assert_response :redirect
    assert_equal items.size, assigns(:odat_diagnosis).diagnosis_items.size

    items = get_diagnosis_items_ids([:e1_1_1])
    put :update, 
        { :medical_record_id => medical_records(:pedrito).id, 
	  :id => odat_diagnoses(:one).id, 
	  :odat_diagnosis => { :diagnosis_item_ids => items }
        }

    assert_response :redirect
    assert_equal items.size, assigns(:odat_diagnosis).diagnosis_items.size
  end

  test "should update center_resources relations" do
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)

    items = get_center_resources_ids([:r1, :r2])
    put :update, 
	{ :medical_record_id => medical_records(:pedrito).id, 
	  :id => odat_diagnoses(:one).id, 
	  :odat_diagnosis => { :center_resource_ids => items }
        }

    assert_redirected_to [medical_records(:pedrito), :odat_diagnoses]
    assert assigns(:odat_diagnosis)
    assert_equal items.size, assigns(:odat_diagnosis).center_resources.size

    items = get_center_resources_ids([:r3])
    put :update, 
        { :medical_record_id => medical_records(:pedrito).id, 
	  :id => odat_diagnoses(:one).id, 
	  :odat_diagnosis => { :center_resource_ids => items }
        }

    assert_response :redirect
    assert_equal items.size, assigns(:odat_diagnosis).center_resources.size
  end

  def test_should_destroy_odat_diagnosis
    login_as_user
    assert_difference('OdatDiagnosis.count', -1) do
      delete :destroy, 
	{ :medical_record_id => medical_records(:pedrito).id, 
	  :id => odat_diagnoses(:one).id
        }
    end

    assert_redirected_to(
    	medical_record_odat_diagnoses_path(
	  :medical_record_id => medical_records(:pedrito).id))
  end

  test "should not destroy if user not in the same center" do
    login_as_user
    assert_no_difference('OdatDiagnosis.count') do
      delete :destroy, 
        { :medical_record_id => medical_records(:paco).id, 
	  :id => odat_diagnoses(:de_paco).id
        }
    end
    assert_redirected_to medical_records_path
  end

  test "should update evaluation_categories_scores_attributes" do
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)

    evaluation_category = evaluation_categories(:two)
    new_score = 1.33
    put :update, 
        { :medical_record_id => medical_records(:pedrito).id, 
    	  :id => odat_diagnoses(:one).id, 
	  :odat_diagnosis =>  { :evaluation_category_scores_attributes => 
                                [
                                  {
                                   :evaluation_category_id => evaluation_category.id.to_s,
                                   :score => new_score.to_s
                                  }
                                ]
                              }
        }

    assert_response :redirect
    assert_equal(new_score, assigns(:odat_diagnosis).get_evaluation_category_score(evaluation_category))
  end

  test "update odat_diagnosis should not duplicate evaluation category scores" do
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)

    odat_diagnosis = odat_diagnoses(:one)
    new_score = 1.33.to_s

    put :update, 
        { :medical_record_id => medical_records(:pedrito).id, 
    	  :id => odat_diagnosis.id, 
	  :odat_diagnosis =>  { :evaluation_category_scores_attributes => 
                                [
                                  {
                                   :evaluation_category_id => evaluation_categories(:one).id.to_s,
                                   :score => new_score
                                  },
                                  {
                                   :evaluation_category_id => evaluation_categories(:two).id.to_s,
                                   :score => new_score
                                  }

                                ]
                              }
        }

    assert_response :redirect
    assert_equal(2, assigns(:odat_diagnosis).evaluation_category_scores.count)
  end

  test "update odat_diagnosis should remove not passed scores" do
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)

    odat_diagnosis = odat_diagnoses(:one)

    put :update, 
        { :medical_record_id => medical_records(:pedrito).id, 
    	  :id => odat_diagnosis.id, 
	  :odat_diagnosis =>  { 
                              }
        }

    assert_response :redirect
    assert_equal(0, assigns(:odat_diagnosis).evaluation_category_scores.count)
  end

protected
  def get_diagnosis_items_ids(fixtures)
    fixtures.collect { |e| diagnosis_items(e).id.to_param }
  end

  def get_center_resources_ids(fixtures)
    fixtures.collect { |e| center_resources(e).id.to_param }
  end

end
