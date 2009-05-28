class CreateComparativeFunctions < ActiveRecord::Migration
  def self.up
    create_table :comparative_functions do |t|
      t.string :applicable_on
      t.text :function
      t.string :render_method
      t.string :render_options

      t.timestamps
    end
  end

  def self.down
    drop_table :comparative_functions
  end
end
