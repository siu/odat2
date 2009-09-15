# encoding: UTF-8
# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  layout 'visitor'

  skip_before_filter :login_required, :only => [:new, :create]

  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      if user.is_admin?
        redirect_to admin_path
      else
        redirect_back_or_default('/')
      end
      flash[:notice] = _('Bienvenido/a')
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = _('Se ha finalizado la sesión')
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = _('No se ha podido iniciar la sesión como %{login}') % {:login => h(params[:login]) }
    logger.warn "Failed login for '#{h params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
