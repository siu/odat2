class AddNameToComparativeFunctions < ActiveRecord::Migration
  def self.up
    add_column :comparative_functions, :name, :string, 
      :null => false, :default => 'unnamed'
  end

  def self.down
    remove_column :comparative_functions, :name
  end
end
