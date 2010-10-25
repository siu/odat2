# encoding: UTF-8
require 'prawn'
require 'prawn/format'

view = @individual_report.configurable_view
@font_size = view.font_size ? view.font_size*0.75 : 12
@border_style = view.table_grid? ? :grid : :underline_header

def h1(pdf, text)
  pdf.text mytag(:h1, text)
  pdf.move_down 40-16
end

def h2(pdf, text)
  pdf.text mytag(:h2, text)
  pdf.move_down 20-14
  text
end

def h3(pdf, text)
  pdf.text mytag(:h3, text)
  pdf.move_down 20-13
end

def mytag(tag, text)
  "<#{tag.to_s}>" << text << "</#{tag.to_s}>"
end

def print_table(pdf, data)
  return if data.empty?
  pdf.table data,
    :border_style => @border_style,
    :column_widths => { 0 => 200},
    :align => :left,
    :font_size => @font_size
  pdf.move_down 20
end

pdf.tags :h1 => {:font_size => @font_size * 1.3333, :font_weight => :bold}
pdf.tags :h2 => {:font_size => @font_size * 1.1666, :font_weight => :bold}
pdf.tags :h3 => {:font_size => @font_size * 1.0833, :font_weight => :bold}
pdf.tags :indent => {:width => '2em'}

pdf.tags :small => {:font_size => @font_size * 0.8333}
pdf.tags :br => {}
pdf.tags :p => {}

pdf.font "#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf"
pdf.font_size = @font_size

# Begin document
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
    data << [_('Dirección'), h(@medical_record.address)]
  end
  if @individual_report.show_handicap_data?
    data << [_('Clasificación de minusvalía mayor que 33 grados'), 
      print_boolean(@medical_record.handicap)]
    data << [_('Grado de dependencia'), 
      (@medical_record.dependency_degree ? '' : h(_("Grado %{dependency_degree}") % { :dependency_degree => @medical_record.dependency_degree} )) ]
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
             h(@medical_record.position_in_siblings)]
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
            l(@medical_record.father_birth_date)] unless @medical_record.father_birth_date.nil? 

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
            l(@medical_record.mother_birth_date)] unless @medical_record.mother_birth_date.nil? 

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
            l(@odat_diagnosis.created_at.to_date)]
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
        pdf.text "<strong> &bull; #{h(cat.name)}</strong>"
        
        for subcat in cat.children
          if subcat.is_ancestor_of_any?(@odat_diagnosis.diagnosis_items)
            pdf.move_down 10
            pdf.text "<indent/> &bull; #{h(subcat.name)}"

            for item in subcat.children
              if item.is_ancestor_of_any?(@odat_diagnosis.diagnosis_items)
                pdf.text "<indent/><indent/> &bull; #{h(item.name)}"
              end
            end

          end
        end
        pdf.move_down 20

      end
    end

  end

  if @individual_report.show_evaluation_scores?
    h3(pdf, _('Apoyos/recursos'))

    for cat_score in @odat_diagnosis.evaluation_category_scores
      data << [h(cat_score.evaluation_category.name), "#{h(cat_score.score)} UMATs"]
    end
    print_table(pdf, data)
    data = []
  end

end

if @individual_report.show_report_data?
  h2(pdf, _('Informe'))
  if @individual_report.show_topic?
    h3(pdf, _('Asunto'))
    pdf.text @individual_report.topic_html
    pdf.move_down 20
  end
  if @individual_report.show_tests?
    h3(pdf, _('Pruebas'))
    pdf.text @individual_report.tests_html
    pdf.move_down 20
  end
  if @individual_report.show_results?
    h3(pdf, _('Resultados'))
    pdf.text @individual_report.results_html
    pdf.move_down 20
  end
  if @individual_report.show_orientation?
    h3(pdf, _('Orientaciones'))
    pdf.text @individual_report.orientation_html
    pdf.move_down 20
  end

end

pdf.move_down 20

if @individual_report.show_signed_on? and @individual_report.signed_on
  pdf.text l(@individual_report.signed_on.to_date, :format => :long), :align => :right
  pdf.move_down 10
end
if @individual_report.show_signature?
  pdf.text h(@individual_report.signature), :align => :right
  pdf.move_down 20
end
