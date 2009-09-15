# encoding: UTF-8
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '3c9e08e92a26b36c519965a610878357'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password

  before_filter :login_required
  before_filter :set_locale
  init_gettext "odat", :content_type => "application/xhtml+xml"

protected
  def set_locale
    I18n.locale = :es
    GetText.locale = "es"
  end

  def locale_rtl?
    return %w(ar).include?GetText.locale.language
  end


end
