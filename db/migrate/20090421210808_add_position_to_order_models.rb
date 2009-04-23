class AddPositionToOrderModels < ActiveRecord::Migration
  def self.up
    add_column :diagnosis_items, :position, :integer
    add_column :jobs, :position, :integer
    add_column :consultation_causes, :position, :integer
    add_column :origin_causes, :position, :integer
    add_column :origin_sources, :position, :integer
    add_column :civil_states, :position, :integer
    add_column :job_statuses, :position, :integer
    add_column :formation_levels, :position, :integer
  end

  def self.down
    remove_column :diagnosis_items, :position
    remove_column :jobs, :position
    remove_column :consultation_causes, :position
    remove_column :origin_causes, :position
    remove_column :origin_sources, :position
    remove_column :civil_states, :position
    remove_column :job_statuses, :position
    remove_column :formation_levels, :position
  end
end
