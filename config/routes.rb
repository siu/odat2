ActionController::Routing::Routes.draw do |map|
  # Users dashboard
  map.root :controller => 'dashboard'

  # Session and user routes
  map.logout '/logout', 
    :controller => 'sessions', :action => 'destroy'
  map.login '/login', 
    :controller => 'sessions', :action => 'new'
  map.resource :user

  # Session
  map.resource :session

  # MedicalRecords
  map.resources :medical_records, 
    :as => 'expedientes' do |record|
    #:shallow => true do |record|
      record.resources :odat_diagnoses, :as => 'diagnosticos'
      record.resources :individual_reports, :as => 'informes'
  end

  # Routes for documentation
  map.docs 'pages/docs', 
    :controller => 'pages', :action => 'show', 
    :permalink => 'docs'

  # Route for about
  map.about 'pages/about', 
    :controller => 'pages', :action => 'show', 
    :permalink => 'about'

  # Routes for other static pages
  map.connect 'pages/:permalink', 
    :controller => 'pages', :action => 'show'

  # Routes for help
  map.namespace :help do |help|
    help.resources :diagnosis_items
    help.resources :jobs
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
    admin.resources :center_resources
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
    admin.resources :pages
  end

  # Default routes, not needed at all
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
