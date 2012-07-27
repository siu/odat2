class UserSessionsController < ApplicationController
  skip_before_filter :login_required
  before_filter :login_prohibited, :only => [:new, :create]
  layout 'visitor', :only => [:new, :create]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])  
    if @user_session.save  
      redirect_to root_url
    else  
      render :action => 'new'  
    end
  end

  def destroy
    @user_session = UserSession.find  
    @user_session.destroy  
    reset_session
    flash[:notice] = _('Has salido del sistema')
    redirect_to root_url
  end

end
