class Help::HelpSectionController < ApplicationController
  layout 'help/help_layout'

  # GET /help/diagnosis_items
  # GET /help/diagnosis_items.xml
  def index
    @diagnosis_items = DiagnosisItem.categories

    respond_to do |format|
      format.html
      format.xml  { render :xml => @diagnosis_items }
    end
  end

  # GET /help/diagnosis_items/1
  # GET /help/diagnosis_items/1.xml
  def show
    @diagnosis_item = DiagnosisItem.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @diagnosis_item }
    end
  end

end
