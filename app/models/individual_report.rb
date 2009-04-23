class IndividualReport < Report
  set_table_name 'individual_reports'
  belongs_to :medical_record
  belongs_to :odat_diagnosia
end
