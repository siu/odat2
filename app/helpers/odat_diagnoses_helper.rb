# encoding: UTF-8
module OdatDiagnosesHelper
  def display_item_for_diagnosis(f, item, diagnoses)
    output = ''
    output << check_box_tag("odat_diagnosis[diagnosis_item_ids][]", 
      item.id,
      diagnoses.include?(item),
      :id => "diagnosis_item_ids_#{item.id}",
      :onchange => "update_main_diagnosis_select(this, #{item.id}, \"#{h item.name}\")")
    output << label_tag("diagnosis_item_ids[#{item.id}]", item.name)
  end

  def hide_attr_if(condition)
    ' style="display: none"' if condition
  end

  def hide_attr_unless(condition)
    hide_attr_if(!condition)
  end
end
