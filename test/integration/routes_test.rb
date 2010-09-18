require 'test_helper'

class RoutesTest < ActionController::IntegrationTest
  test '/expedientes_full.csv should route to medical_records/index_full.csv' do
    assert_routing 'expedientes_full.csv', { :controller => 'medical_records', :action => 'index_full', :format => :csv }
  end 
end
