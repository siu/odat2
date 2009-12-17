# encoding: UTF-8
class Admin::AdminSectionController < ApplicationController
  skip_before_filter :login_required, :only => [:help, :help_index]

  layout 'admin/admin_layout'

protected
  def login_required
    render_optional_error_file(404) unless current_user && current_user.role?(:admin)
  end
end
