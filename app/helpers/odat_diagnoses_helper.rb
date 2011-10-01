# encoding: UTF-8
module OdatDiagnosesHelper
  def item_for_diagnosis(f, item, diagnoses, opts={})
    output = ''
    output << check_box_tag("odat_diagnosis[diagnosis_item_ids][]", 
      item.id,
      diagnoses.include?(item),
      opts.merge(:id => "diagnosis_item_ids_#{item.id}"))
    output << label_tag("diagnosis_item_ids[#{item.id}]", item.name)
    if not item.leaf?
      if item.multiple_select?
        output << check_boxes_for_diagnosis(f, item, diagnoses)
      else
        output << radio_boxes_for_diagnosis(f, item, diagnoses)
      end
    end
    output
  end

  def check_boxes_for_diagnosis(f, item, diagnoses)
    output = ' '
    output << f.collection_select(:diagnosis_item_ids, item.children, :id, :name)

    output = '<ul>'
    item.children.each do |item|
      output << '<li>' << check_box_tag("odat_diagnosis[diagnosis_item_ids][]", 
        item.id,
        diagnoses.include?(item),
        :id => "diagnosis_item_ids_#{item.id}")
      output << label_tag("diagnosis_item_ids[#{item.id}]", item.name)
      output << '</li>'
    end
    output << '</ul>'
    output
  end

  def radio_boxes_for_diagnosis(f, item, diagnoses)
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
