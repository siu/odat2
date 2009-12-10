require 'test_helper'
require 'performance_test_help'

# Profiling results for each test method are written to tmp/performance.
class BrowsingTest < ActionController::PerformanceTest
  def test_homepage
    get '/'
  end

  def test_dashboard
    login_as_user
    get '/'
  end

  def test_medical_records_index
    login_as_user
    get '/expedientes'
  end

  def test_center_reports_index
    login_as_user
    get '/center_reports'
  end

protected

  def login_as_user
    post '/session/create', :login => 'quentin', :password => 'monkey'
  end
end
