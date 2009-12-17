ActionController::Routing::Routes.draw do |map|
  # Users dashboard
  map.root :controller => 'dashboard'
  map.dashboard '', :controller => 'dashboard'

  # Session and user routes
  map.resource :user_session
  map.resources :users
  map.account '/account', :controller => "users", :action => 'show'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  map.login  '/login',  :controller => 'user_sessions', :action => 'new'

  # MedicalRecords
  map.resources :medical_records, :as => 'expedientes' do |record|
    #:shallow => true do |record|
      record.resources :odat_diagnoses, :as => 'diagnosticos'
      record.resources :individual_reports, :as => 'informes'
  end

  # Center Reports
  map.resources :center_reports

  # Comparative Reports
  # Should remove this line
  map.resources :comparative_reports

  # Routes for documentation
  map.with_options :controller => 'pages', :action => 'show' do |pages|
    pages.docs 'pages/docs', :permalink => 'docs'
    pages.about 'pages/about', :permalink => 'about'
    pages.connect 'pages/:permalink'
  end

  # Routes for help
  map.namespace :help do |help|
    help.resources :diagnosis_items
    help.resources :jobs
  end

  # Admin dashboard
  map.admin_root '/admin', :controller => 'admin/dashboard'

  # Admin section
  map.namespace :admin do |admin|
    # Users
    admin.resources :users, 
      :member => { 
        :show => :get,
	:activate => :put, 
	:deactivate => :put, 
	:approve => :put, 
	:deapprove => :put, 
	:confirm => :put,
	:unconfirm => :put }

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
    admin.resources :report_field_templates,       :name_prefix => nil
    admin.resources :comparative_report_templates, :name_prefix => nil
    admin.resources :school_types,                 :name_prefix => nil
  end

  map.contact 'contact_us', :controller => 'help/contact_us'
  map.connect '404', :controller => 'application', :action => 'rescue_404'

  # Default routes, not needed at all
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
