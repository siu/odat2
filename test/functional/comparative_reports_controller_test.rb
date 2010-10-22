require 'test_helper'

class ComparativeReportsControllerTest < ActionController::TestCase
  test "should get index" do
    login_as_user
    get :index
    assert_response :success
    assert_not_nil assigns(:comparative_reports)
  end

  test "should get new" do
    login_as_user
    get :new
    assert_response :success
  end

  test "should create comparative_report" do
    login_as_user
    ComparativeReport.any_instance.stubs(:valid?).returns(:true)
    assert_difference('ComparativeReport.count') do
      post :create, :comparative_report => { }
    end

    assert_redirected_to comparative_report_path(assigns(:comparative_report))
  end

  test "should show comparative_report" do
    login_as_user
    get :show, :id => comparative_reports(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as_user
    get :edit, :id => comparative_reports(:one).to_param
    assert_response :success
  end

  test "should update comparative_report" do
    login_as_user
    ComparativeReport.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => comparative_reports(:one).to_param, :comparative_report => { }
    assert_redirected_to comparative_report_path(assigns(:comparative_report))
  end

  test "should destroy comparative_report" do
    login_as_user
    assert_difference('ComparativeReport.count', -1) do
      delete :destroy, :id => comparative_reports(:one).to_param
    end

    assert_redirected_to comparative_reports_path
  end

  test "should update comparative_report_field_template_attributes" do
    login_as_user
    ComparativeReport.any_instance.stubs(:valid?).returns(:true)

    report_field_template1 = report_field_templates(:for_medical_records3)
    report_field_template2 = report_field_templates(:for_medical_records4)
    put :update, 
      { 
        :id => comparative_reports(:one).id, 
        :comparative_report =>  { 
          :report_field_template_ids => 
              [report_field_template1.id.to_s, report_field_template2.id.to_s]
        }
      }

    assert_response :redirect
    assert(assigns(:comparative_report).report_field_templates.include?(report_field_template1))
    assert(assigns(:comparative_report).report_field_templates.include?(report_field_template2))
    assert_equal(2, assigns(:comparative_report).report_field_templates.count)
  end

  test "should not store duplicates on update comparative_report_field_template_attributes" do
    login_as_user
    ComparativeReport.any_instance.stubs(:valid?).returns(:true)

    report_field_template1 = report_field_templates(:for_medical_records3)
    put :update, 
      { 
        :id => comparative_reports(:one).id, 
        :comparative_report =>  { 
          :report_field_template_ids => 
              [report_field_template1.id.to_s, report_field_template1.id.to_s]
        }
      }

    assert_response :redirect
    assert(assigns(:comparative_report).report_field_templates.include?(report_field_template1))
    assert_equal(1, assigns(:comparative_report).report_field_templates.count)
  end

  test "should remove not passed comparative_report_field_templates" do
    login_as_user
    ComparativeReport.any_instance.stubs(:valid?).returns(:true)

    assert(comparative_reports(:one).report_field_templates.count > 0)
    put :update, 
      { 
        :id => comparative_reports(:one).id, 
        :comparative_report =>  { 
          :report_field_template_ids => []
        }
      }

    assert_response :redirect
    assert_equal(0, assigns(:comparative_report).report_field_templates.count)
  end

# test "update odat_diagnosis should not duplicate evaluation category scores" do
#   login_as_user
#   OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
#
#   odat_diagnosis = odat_diagnoses(:one)
#   new_score = 1.33.to_s
#
#   put :update, 
#     { :medical_record_id => medical_records(:pedrito).id, 
#       :id => odat_diagnosis.id, 
#       :odat_diagnosis =>  { 
#         :evaluation_category_scores_attributes => {
#           0 => {
#             :evaluation_category_id => evaluation_categories(:one).id.to_s,
#             :score => new_score
#           },
#           1 => {
#             :evaluation_category_id => evaluation_categories(:two).id.to_s,
#             :score => new_score
#           }
#         }
#       }
#     }
#
#   assert_response :redirect
#   assert_equal(2, assigns(:odat_diagnosis).evaluation_category_scores.count)
# end
#
# test "update odat_diagnosis should remove not passed scores" do
#   login_as_user
#   OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
#
#   odat_diagnosis = odat_diagnoses(:one)
#
#   put :update, 
#       { :medical_record_id => medical_records(:pedrito).id, 
#   	  :id => odat_diagnosis.id, 
#         :odat_diagnosis =>  { 
#                             }
#       }
#
#   assert_response :redirect
#   assert_equal(0, assigns(:odat_diagnosis).evaluation_category_scores.count)
# end

end
