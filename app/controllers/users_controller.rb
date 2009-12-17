class UsersController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create]
  def show
  end

  def new
  end

  def edit
  end

end
