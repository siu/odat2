require 'prawn/format'

def h1(pdf, text)
  pdf.text tag :h1, text
  pdf.move_down 40-16
end

def h2(pdf, text)
  pdf.text tag :h2, text
  pdf.move_down 20-14
  text
end

def h3(pdf, text)
  pdf.text tag :h3, text
  pdf.move_down 20-12
end

def tag(tag, text)
  "<#{tag.to_s}>" << text << "</#{tag.to_s}>"
end

def print_table(pdf, data)
  return if data.empty?
  pdf.table data,
    :border_style => :grid,
    :column_widths => { 0 => 200},
    :align => :left
  pdf.move_down 20
end

pdf.tags :h1 => {:font_size => 16, :font_weight => :bold}
pdf.tags :h2 => {:font_size => 14, :font_weight => :bold}
pdf.tags :h3 => {:font_size => 12, :font_weight => :bold}
pdf.tags :indent => {:width => '2em'}

pdf.tags :small => {:font_size => 10}
pdf.tags :br => {}
pdf.tags :p => {}

pdf.font "Helvetica" 

h1(pdf, _('Informe para %{full_name}') % {:full_name => @individual_report.medical_record.full_name})

data = []

if @individual_report.show_personal_data?
  h2(pdf, _('Datos personales'))
  if @individual_report.show_full_name?
    data << [_('Nombre'), h(@medical_record.full_name)]
  end
  if @individual_report.show_medical_record_archive_date? && 
        @medical_record.archive_date
    data << [_('Fecha de ingreso'), l(@medical_record.archive_date)]
  end
  if @individual_report.show_birth_date? && @medical_record.birth_date 
    data << [_('Fecha de nacimiento'), l(@medical_record.birth_date)]
  end
  if @individual_report.show_age?
    data << [_('Edad'), h(@medical_record.age)]
  end
  if @individual_report.show_gender?
    data << [_('Sexo'), h(@medical_record.gender)]
  end
  if @individual_report.show_birth_position?
    data << [_('Número de parto <small>(en caso de parto múltiple)</small>'),
             h(@medical_record.birth_position)]
  end
  if @individual_report.show_address?
    data << [_('Direccion'), h(@medical_record.address)]
  end

  print_table(pdf, data)
  data = []
end

if @individual_report.show_family_data?
  h2(pdf, _('Datos sociofamiliares'))
  if @individual_report.show_siblings_data?
    h3(pdf, _('Hermanos'))
    data << [_('Número total de hermanos'), 
             h(@medical_record.total_siblings_amount)]
    data << [_('Lugar que ocupa'), 
             h(@medical_record.birth_position)]
    print_table(pdf, data)
    data = []
  end

  if @individual_report.show_father_data?
    h3(pdf, _('Padre'))

    data << [_('Nombre'),
            h(@medical_record.father_name)]

    data << [_('Apellidos'),
            h(@medical_record.father_surname)]

    data << [_('Fecha de nacimiento') ,
            l(@medical_record.father_birth_date, :format => :short)] unless @medical_record.father_birth_date.nil? 

    data << [_('Situación laboral') ,
            h(@medical_record.father_job_status.name)] unless @medical_record.father_job_status.nil? 

    data << [_('Ocupación') ,
            h(@medical_record.father_job.name)] unless @medical_record.father_job.nil? 

    data << [_('Nivel de estudios') ,
            h(@medical_record.father_formation_level.name)] unless @medical_record.father_formation_level.nil? 

    data << [_('Estado civil') ,
            h(@medical_record.father_civil_state.name)] unless @medical_record.father_civil_state.nil? 

    data << [_('Email') ,
            h(@medical_record.father_email)]

    data << [_('Información extra') ,
            h(@medical_record.father_extra_information)]

    print_table(pdf, data)
    data = []
  end

  if @individual_report.show_mother_data?
    h3(pdf, _('Madre'))

    data << [_('Nombre'),
            h(@medical_record.mother_name)]

    data << [_('Apellidos'),
            h(@medical_record.mother_surname)]

    data << [_('Fecha de nacimiento') ,
            l(@medical_record.mother_birth_date, :format => :short)] unless @medical_record.mother_birth_date.nil? 

    data << [_('Situación laboral') ,
            h(@medical_record.mother_job_status.name)] unless @medical_record.mother_job_status.nil? 

    data << [_('Ocupación') ,
            h(@medical_record.mother_job.name)] unless @medical_record.mother_job.nil? 

    data << [_('Nivel de estudios') ,
            h(@medical_record.mother_formation_level.name)] unless @medical_record.mother_formation_level.nil? 

    data << [_('Estado civil') ,
            h(@medical_record.mother_civil_state.name)] unless @medical_record.mother_civil_state.nil? 

    data << [_('Email') ,
            h(@medical_record.mother_email)]

    data << [_('Información extra') ,
            h(@medical_record.mother_extra_information)]

    print_table(pdf, data)
    data = []
  end

  if @individual_report.show_phone_numbers?
    h3(pdf, _('Teléfonos'))

    data << [_('Domicilio'),
             h(@medical_record.home_phone)]

    data << [_('Móvil'),
             h(@medical_record.portable_phone)]

    data << [_('Trabajo'),
             h(@medical_record.work_phone)]

    print_table(pdf, data)
    data = []
  end 

  if @individual_report.show_coordination_services?
    h3(pdf, _('Coordinación'))
    data << [_('Servicios Sanitarios'),
             print_boolean(@medical_record.sanitary_services)]
    data << [_('Servicios Sociales'),
             print_boolean(@medical_record.social_services)]
    data << [_('Servicios Educativos'),
             print_boolean(@medical_record.educative_services)]

    print_table(pdf, data)
    data = []
  end
end

if @individual_report.show_diagnosis_data?
  h2(pdf, _('Datos de diagnóstico'))
  if @individual_report.show_diagnosis_created_at? && @odat_diagnosis.created_at
    h3(pdf, _('Fecha de creación del diagnóstico'))
    
    data << [_('Fecha de creación'),
            l(@odat_diagnosis.created_at, :format => :short)]
    print_table(pdf, data)
    data = []
  end
  if @individual_report.show_consultation_details?
    h3(pdf, _('Datos de demanda'))

    if @odat_diagnosis.origin_source
      data << [_('Fuente de derivación'),
               h(@odat_diagnosis.origin_source.name)]
    end

    if @odat_diagnosis.origin_cause
      data << [_('Motivo de derivación'),
               h(@odat_diagnosis.origin_cause.name)]
    end

    if @odat_diagnosis.consultation_cause
      data << [_('Motivo de consulta expresado por los padres'),
               h(@odat_diagnosis.consultation_cause.name)]
    end

    data << [_('Denominación'),
             h(@odat_diagnosis.description)]

    print_table(pdf, data)
    data = []
  end
  
  if @individual_report.show_center_resources?
    h3(pdf, _('Datos de centro'))
    
    for resource in @odat_diagnosis.center_resources do
      pdf.text "<indent/>&bull; " << h(resource.name)
    end

    pdf.move_down 20

  end

  if @individual_report.show_main_diagnosis?
    h3(pdf, _('Diagnóstico principal'))
    if @odat_diagnosis.main_diagnosis
        pdf.text h(@odat_diagnosis.main_diagnosis.name)
    else
        pdf.text _('No se ha indicado un diagnóstico principal.')
    end
    pdf.move_down 20
  end

  if @individual_report.show_detailed_diagnosis?
    h3(pdf, _('Datos de diagnóstico'))

    for cat in DiagnosisItem.roots
      if cat.is_ancestor_of_any?(@odat_diagnosis.diagnosis_items)
        pdf.text cat.name
        
        for subcat in cat.children
          if subcat.is_ancestor_of_any?(@odat_diagnosis.diagnosis_items)
            pdf.text "<indent/>#{subcat.name}"

            for item in subcat.children
              if item.is_ancestor_of_any?(@odat_diagnosis.diagnosis_items)
                pdf.text "<indent/><indent/> &bull; #{item.name}"
              end
            end

          end
        end
        pdf.move_down 20

      end
    end

  end

end

if @individual_report.show_report_data?
  h2(pdf, _('Informe'))
  if @individual_report.show_topic?
    h3(pdf, _('Asunto'))
    pdf.text @individual_report.topic_html
  end
  if @individual_report.show_tests?
    h3(pdf, _('Pruebas'))
    pdf.text @individual_report.tests_html
  end
  if @individual_report.show_results?
    h3(pdf, _('Resultados'))
    pdf.text @individual_report.results_html
  end
  if @individual_report.show_orientation?
    h3(pdf, _('Orientaciones'))
    pdf.text @individual_report.orientation_html
  end
  if @individual_report.show_signed_on? and @individual_report.signed_on
    pdf.text l(@individual_report.signed_on.to_date, :format => :short)
  end
  if @individual_report.show_signature?
    pdf.text _('Firma') << ': ' << h(@individual_report.signature)
  end
end