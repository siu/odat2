class AddDescriptionHtmlFields < ActiveRecord::Migration
  def self.up
    add_column :center_resources,    :description_html, :text
    add_column :civil_states,        :description_html, :text
    add_column :consultation_causes, :description_html, :text
    add_column :formation_levels,    :description_html, :text
    add_column :job_statuses,        :description_html, :text
    add_column :jobs,                :description_html, :text
    add_column :odat_diagnoses,      :description_html, :text
    add_column :origin_causes,       :description_html, :text
    add_column :origin_sources,      :description_html, :text
  end

  def self.down
    remove_column :center_resources
    remove_column :civil_states
    remove_column :consultation_causes
    remove_column :formation_levels
    remove_column :job_statuses
    remove_column :jobs
    remove_column :odat_diagnoses
    remove_column :origin_causes
    remove_column :origin_sources
  end
end
