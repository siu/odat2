# encoding: UTF-8
class ItemReportAssociation < ActiveRecord::Base
  belongs_to :comparative_report
  belongs_to :item, :polymorphic => true

  def self.new_for(comparative_report, item)
    o = self.new()
    o.comparative_report = comparative_report
    o.item = item
    o
  end
end
