class CreateSchoolTypes < ActiveRecord::Migration
  def self.up
    create_table :school_types do |t|
      t.string :name
      t.text :description
      t.text :description_html

      t.timestamps
    end
  end

  def self.down
    drop_table :school_types
  end
end
