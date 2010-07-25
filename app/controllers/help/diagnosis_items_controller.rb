# encoding: UTF-8
class Help::DiagnosisItemsController < Help::HelpSectionController
  # GET /help/diagnosis_items
  # GET /help/diagnosis_items.xml
  def index
    @diagnosis_items = DiagnosisItem.roots
  end

  # GET /diagnosis_items/1
  # GET /diagnosis_items/1.xml
  def show
    @diagnosis_item = DiagnosisItem.find(params[:id])
  end
end
