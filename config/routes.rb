ActionController::Routing::Routes.draw do |map|

  # Users dashboard
  map.root :controller => 'dashboard'

  # Session and user routes
  map.logout '/logout', 
    :controller => 'sessions', :action => 'destroy'
  map.login '/login', 
    :controller => 'sessions', :action => 'new'
  map.resources :users

  # map.register '/register', 
  #   :controller => 'users', :action => 'create'
  # map.signup '/signup', 
  #   :controller => 'users', :action => 'new'

  # User activation
  # map.activate '/activate/:activation_code', 
  #   :controller => 'users', 
  #   :action => 'activate', 
  #   :activation_code => nil

  # Session
  map.resource :session

  # MedicalRecords
  map.resources :medical_records, 
    :as => 'expedientes' do |record|
    #:shallow => true do |record|
      record.resources :odat_diagnoses, :as => 'diagnosticos'
  end

  # Admin dashboard
  map.admin '/admin', :controller => 'admin/dashboard'

  # Admin section
  map.namespace :admin do |admin|
    # Users
    admin.resources :users, 
      :member => { 
	:suspend => :put, 
	:unsuspend => :put, 
	:purge => :delete }

    # All other resources
    admin.resources :regions
    admin.resources :centers
    admin.resources :formation_levels
    admin.resources :job_statuses
    admin.resources :civil_states
    admin.resources :jobs
    admin.resources :consultation_causes
    admin.resources :origin_causes
    admin.resources :origin_sources
    admin.resources :diagnosis_items
    admin.resources :provinces
  end

  # Default routes, not needed at all
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
