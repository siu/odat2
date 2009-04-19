class Admin < User
  def is_admin?
    true
  end
  def medical_records
    MedicalRecord.find(:all)
  end
end
