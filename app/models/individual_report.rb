# encoding: UTF-8
class IndividualReport < Report
  set_table_name 'individual_reports'

  # Both needed here because it can be associated to a medica_record and
  # not to an odat_diagnosis
  belongs_to :odat_diagnosis
  belongs_to :medical_record

  acts_as_html_text

  def show_personal_data?
    [
      :show_full_name?, 
      :show_birth_date?, 
      :show_age?, 
      :show_medical_record_archive_date?, 
      :show_gender?, 
      :show_address?
    ].any? do |a|
      self.send(a)
    end
  end

  def show_family_data?
    [
      [:show_siblings_data?, :has_siblings_data?],
      [:show_birth_position?, :has_siblings_data?],
      [:show_father_data?, :has_father_data?],
      [:show_mother_data?, :has_mother_data?],
      [:show_phone_numbers?, :has_phone_data?]
    ].any? do |a|
      self.send(a[0]) && self.medical_record.send(a[1])
    end
  end

  def show_diagnosis_data?
    [
      :show_diagnosis_created_at?, 
      :show_consultation_details?, 
      :show_center_resources?, 
      :show_detailed_diagnosis?, 
      :show_main_diagnosis?
    ].any? do |a|
      self.send(a)
    end
  end

  def show_report_data?
    show = [
      :show_topic?,
      :show_tests?, 
      :show_results?, 
      :show_orientation?, 
      :show_main_diagnosis?
    ].any? do |a|
      self.send(a)
    end

    show or (self.show_signature? and !self.signature.empty?) or
       (self.show_signed_on? and !self.signed_on.nil?)
  end

  def show_topic?
    !topic_html.nil? && !topic_html.empty?
  end

  def show_tests?
    !tests_html.nil? && !tests_html.empty?
  end

  def show_results?
    !results_html.nil? && !results_html.empty?
  end

  def show_orientation?
    !orientation_html.nil? && !orientation_html.empty?
  end
end
