module OdatDiagnosesHelper
  def display_item_for_diagnosis(f, item, diagnoses)
    output = ''
    output << f.check_box("diagnosis_item_ids[#{item.id}]", 
			  :value => item.id, 
			  :checked => diagnoses.to_a.include?(item),
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
