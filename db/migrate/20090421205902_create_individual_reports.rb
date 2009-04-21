class CreateIndividualReports < ActiveRecord::Migration
  def self.up
    create_table :individual_reports do |t|
      t.integer :medical_record_id
      t.integer :odat_diagnosis_id
      t.text :topic
      t.text :topic_html
      t.text :tests
      t.text :tests_html
      t.text :results
      t.text :results_html
      t.text :orientation
      t.text :orientation_html

      t.timestamps
    end
  end

  def self.down
    drop_table :individual_reports
  end
end
