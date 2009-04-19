class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :permalink
      t.text :sidebar_content
      t.text :sidebar_content_html
      t.text :content
      t.text :content_html

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
