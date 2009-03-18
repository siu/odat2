class CreateConsultationCauses < ActiveRecord::Migration
  def self.up
    create_table :consultation_causes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :consultation_causes
  end
end
