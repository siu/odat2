# encoding: UTF-8
class PagesController < ApplicationController
  def show
    @page = Page.find_by_permalink(params[:permalink])
    raise ActiveRecord::RecordNotFound if @page.nil?
  end
end
