class Admin::AdminSectionController < ApplicationController
protected
  def login_required
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 unless logged_in? && current_user.is_admin?
  end
end
