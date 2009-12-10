# encoding: UTF-8
class DashboardController < ApplicationController
  def index
    items_per_category = 6
    @medical_records = current_user.center.medical_records.find(:all, :limit => items_per_category, :order => 'medical_records.updated_at DESC')
    @odat_diagnoses = current_user.center.odat_diagnoses.find(:all, :limit => items_per_category, :order => 'odat_diagnoses.updated_at DESC')
    @individual_reports = current_user.center.individual_reports.find(:all, :limit => items_per_category, :order => 'individual_reports.updated_at DESC')
    @center_reports = current_user.center.center_reports.find(:all, :limit => items_per_category, :order => 'comparative_reports.updated_at DESC')
  end
end
