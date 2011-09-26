# encoding: UTF-8
module OdatDiagnosesHelper
  def display_item_for_diagnosis(f, item, diagnoses)
    output = ''
    output << check_box_tag("odat_diagnosis[diagnosis_item_ids][]", 
      item.id,
      diagnoses.include?(item),
      :id => "diagnosis_item_ids_#{item.id}",
      :class => "leaf")
    output << label_tag("diagnosis_item_ids[#{item.id}]", item.name)
    if not item.leaf?
      output << display_checkboxes_for_diagnosis(f, item, diagnoses)
    end
    output
  end

  def display_dropdown_for_diagnosis(f, item, diagnoses)
    output = ' '
    output << f.collection_select(:diagnosis_item_ids, item.children, :id, :name)
  end

  def display_checkboxes_for_diagnosis(f, item, diagnoses)
    output = '<ul>'
    item.children.each do |item|
      output << '<li>' << radio_button_tag("odat_diagnosis[diagnosis_item_ids][]", 
        item.id,
        diagnoses.include?(item),
        :id => "diagnosis_item_ids_#{item.id}")
      output << label_tag("diagnosis_item_ids[#{item.id}]", item.name)
      output << '</li>'
    end
    output << '</ul>'
    output
  end

  def hide_attr_if(condition)
    ' style="display: none"' if condition
  end

  def hide_attr_unless(condition)
    hide_attr_if(!condition)
  end
end
