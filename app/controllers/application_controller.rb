# encoding: UTF-8
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Protect cookies
  protect_from_forgery

  before_filter :login_required
  before_filter :set_gettext_locale

  helper :all
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation

  # Errors
  def rescue_404
    render  :template => "/errors/404.html.erb", 
            :status => :not_found, 
            :layout => 'visitor.html.erb'
  end

private

  def local_request?
    false
  end

  def render_optional_error_file(status_code)
    status = interpret_status(status_code)
    render  :template => "/errors/#{status[0,3]}.html.erb", 
    :status => status, 
    :layout => 'visitor.html.erb'
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def login_required
    unless current_user
      store_location
      flash[:notice] = _('Es necesario iniciar sesión para visitar esta página')
      redirect_to login_url
      return false
    end
  end

  def login_prohibited
    if current_user
      store_location
      flash[:notice] = _('Debes cerrar sesión para visitar esta página')
      redirect_to account_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
