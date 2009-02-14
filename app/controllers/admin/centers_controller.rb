class Admin::CentersController < Admin::AdminSectionController
  resource_this :will_paginate => true
  alias :center_url :admin_center_url
  alias :centers_url :admin_centers_url
  alias :center_path :admin_center_path
  alias :centers_path :admin_centers_path
end
