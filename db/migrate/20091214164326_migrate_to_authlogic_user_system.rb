class MigrateToAuthlogicUserSystem < ActiveRecord::Migration
  def self.up
    drop_table :users

    create_table :users do |t|
      t.timestamps
      t.string   :login,              :null => false, :limit => 25
      t.string   :email,              :null => false
      t.string   :crypted_password,   :null => false, :limit => 128
      t.string   :password_salt,      :null => false
      t.string   :persistence_token,  :null => false
      t.string   :perishable_token,   :null => false # For password resets

      # Magic columns
      t.integer  :login_count,        :null => false, :default => 0
      t.integer  :failed_login_count, :null => false, :default => 0
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string   :last_login_ip
      t.string   :current_login_ip
    end
    
    add_index :users, :login
    add_index :users, :persistence_token
    add_index :users, :last_request_at
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
