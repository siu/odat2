# encoding: UTF-8
class Admin::UsersController < Admin::AdminSectionController
  
  before_filter :find_user, 
    :only => [:edit, :suspend, :unsuspend, :destroy, :purge]
  
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
 
  def create
    # logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      redirect_back_or_default(root_path)
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
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

  def suspend
    @user.suspend! 
    redirect_to admin_users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to admin_users_path
  end

  def destroy
    @user.delete!
    redirect_to admin_users_path
  end

  def purge
    @user.destroy
    redirect_to admin_users_path
  end

protected
  def find_user
    @user = User.find(params[:id], :include => :center)
  end

  def load_data
    @centers = Center.find(:all)
  end
end
