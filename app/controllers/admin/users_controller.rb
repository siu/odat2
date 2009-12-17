# encoding: UTF-8
class Admin::UsersController < Admin::AdminSectionController
  
  before_filter :find_user, 
    :only => [:show, :edit, :activate, :deactivate, :approve, :deapprove, :confirm, :unconfirm, :destroy]
  
  # render new.rhtml
  def new
    load_data
    @user = User.new
  end

  def index
    @users = User.paginate(:page => params[:page], 
			       :order => 'login ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show; end
 
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
      redirect_to [:admin, @user]
    else
      load_data
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.
  def edit
    load_data
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Usuario was successfully updated.'
        format.html { redirect_to([:admin, @user]) }
        format.xml  { head :ok }
      else
        format.html { 
	  load_data
	  render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def deactivate
    flash[:notice] = _('El usuario ha sido desactivado correctamente') if @user.deactivate! 
    redirect_to admin_users_path
  end

  def activate
    flash[:notice] = _('El usuario ha sido activado correctamente') if @user.activate! 
    redirect_to admin_users_path
  end

  def approve
    flash[:notice] = _('El usuario ha sido aprovado correctamente') if @user.approve! 
    redirect_to admin_users_path
  end

  def deapprove
    flash[:notice] = _('El usuario ha sido desaprovado correctamente') if @user.deapprove! 
    redirect_to admin_users_path
  end

  def confirm
    flash[:notice] = _('El usuario ha sido confirmado correctamente') if @user.confirm! 
    redirect_to admin_users_path
  end

  def unconfirm
    flash[:notice] = _('El usuario ha sido desconfirmado correctamente') if @user.unconfirm! 
    redirect_to admin_users_path
  end

  def destroy
    self.deactivate
  end

protected
  def find_user
    @user = User.find(params[:id], :include => :center)
  end

  def load_data
    @centers = Center.find(:all)
  end
end
