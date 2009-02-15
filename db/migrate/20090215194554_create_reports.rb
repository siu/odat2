class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.boolean	  :show_signature, :default => true
      t.string	  :signature, :limit => 150
      t.boolean	  :show_signed_on, :default => true
      t.datetime  :signed_on
      t.integer	  :font_size, :default => 0
      t.string	  :font_family, :limit => 150

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
