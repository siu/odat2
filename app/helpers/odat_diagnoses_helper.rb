module OdatDiagnosesHelper
  def display_item_for_diagnosis(f, item, diagnoses)
    output = ''
    output << check_box_tag("odat_diagnosis[diagnosis_item_ids][]", 
			  item.id,
			  diagnoses.to_a.include?(item),
			  :onchange => "update_main_diagnosis_list(this, #{item.id}, \"#{h item.name}\")")
    output << f.label("diagnosis_item_ids[#{item.id}]", item.name)
    output << " <small>(#{link_to(_('ayuda'), 
		  {:controller => :help},
		  :target => '_blank', 
		  :onclick => 'link_popup(this); return false;')})</small>"
  end

  def hide_attr_if(condition)
    ' style="display: none"' if condition
  end

  def hide_attr_unless(condition)
    hide_attr_if(!condition)
  end
end
