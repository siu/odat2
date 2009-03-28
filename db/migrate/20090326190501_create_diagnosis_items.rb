class CreateDiagnosisItems < ActiveRecord::Migration
  def self.up
    create_table :diagnosis_items do |t|
      t.string	:name
      t.string	:description
      t.string	:description_html
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.timestamps
    end
  end

  def self.down
    drop_table :diagnosis_items
  end
end
