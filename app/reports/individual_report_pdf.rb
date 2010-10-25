# encoding: UTF-8
class IndividualReportPdf < ReportPdf

  def view
    # Begin document
    h1(_('Informe para %{full_name}') % {:full_name => @report.medical_record.full_name})

    data = []

    if @report.show_personal_data?
      h2(_('Datos personales'))
      if @report.show_full_name?
        data << [_('Nombre'), h(@report.medical_record.full_name)]
      end
      if @report.show_medical_record_archive_date? && 
        @report.medical_record.archive_date
        data << [_('Fecha de ingreso'), l(@report.medical_record.archive_date)]
      end
      if @report.show_birth_date? && @report.medical_record.birth_date 
        data << [_('Fecha de nacimiento'), l(@report.medical_record.birth_date)]
      end
      if @report.show_age?
        data << [_('Edad'), h(@report.medical_record.age)]
      end
      if @report.show_gender?
        data << [_('Sexo'), h(@report.medical_record.gender)]
      end
      if @report.show_birth_position?
        data << [_('Número de parto <small>(en caso de parto múltiple)</small>'),
          h(@report.medical_record.birth_position)]
      end
      if @report.show_address?
        data << [_('Dirección'), h(@report.medical_record.address)]
      end
      if @report.show_handicap_data?
        data << [_('Clasificación de minusvalía mayor que 33 grados'), 
          print_boolean(@report.medical_record.handicap)]
        data << [_('Grado de dependencia'), 
          (@report.medical_record.dependency_degree ? '' : h(_("Grado %{dependency_degree}") % { :dependency_degree => @report.medical_record.dependency_degree} )) ]
      end

      print_table(data)
      data = []
    end

    if @report.show_family_data?
      h2(_('Datos sociofamiliares'))
      if @report.show_siblings_data?
        h3(_('Hermanos'))
        data << [_('Número total de hermanos'), 
          h(@report.medical_record.total_siblings_amount)]
        data << [_('Lugar que ocupa'), 
          h(@report.medical_record.position_in_siblings)]
        print_table(data)
        data = []
      end

      if @report.show_father_data?
        h3(_('Padre'))

        data << [_('Nombre'),
          h(@report.medical_record.father_name)]

        data << [_('Apellidos'),
          h(@report.medical_record.father_surname)]

        data << [_('Fecha de nacimiento') ,
          l(@report.medical_record.father_birth_date)] unless @report.medical_record.father_birth_date.nil? 

        data << [_('Situación laboral') ,
          h(@report.medical_record.father_job_status.name)] unless @report.medical_record.father_job_status.nil? 

        data << [_('Ocupación') ,
          h(@report.medical_record.father_job.name)] unless @report.medical_record.father_job.nil? 

        data << [_('Nivel de estudios') ,
          h(@report.medical_record.father_formation_level.name)] unless @report.medical_record.father_formation_level.nil? 

        data << [_('Estado civil') ,
          h(@report.medical_record.father_civil_state.name)] unless @report.medical_record.father_civil_state.nil? 

        data << [_('Email') ,
          h(@report.medical_record.father_email)]

        data << [_('Información extra') ,
          h(@report.medical_record.father_extra_information)]

        print_table(data)
        data = []
      end

      if @report.show_mother_data?
        h3(_('Madre'))

        data << [_('Nombre'),
          h(@report.medical_record.mother_name)]

        data << [_('Apellidos'),
          h(@report.medical_record.mother_surname)]

        data << [_('Fecha de nacimiento') ,
          l(@report.medical_record.mother_birth_date)] unless @report.medical_record.mother_birth_date.nil? 

        data << [_('Situación laboral') ,
          h(@report.medical_record.mother_job_status.name)] unless @report.medical_record.mother_job_status.nil? 

        data << [_('Ocupación') ,
          h(@report.medical_record.mother_job.name)] unless @report.medical_record.mother_job.nil? 

        data << [_('Nivel de estudios') ,
          h(@report.medical_record.mother_formation_level.name)] unless @report.medical_record.mother_formation_level.nil? 

        data << [_('Estado civil') ,
          h(@report.medical_record.mother_civil_state.name)] unless @report.medical_record.mother_civil_state.nil? 

        data << [_('Email') ,
          h(@report.medical_record.mother_email)]

        data << [_('Información extra') ,
          h(@report.medical_record.mother_extra_information)]

        print_table(data)
        data = []
      end

      if @report.show_phone_numbers?
        h3(_('Teléfonos'))

        data << [_('Domicilio'),
          h(@report.medical_record.home_phone)]

        data << [_('Móvil'),
          h(@report.medical_record.portable_phone)]

        data << [_('Trabajo'),
          h(@report.medical_record.work_phone)]

        print_table(data)
        data = []
      end 

      if @report.show_coordination_services?
        h3(_('Coordinación'))
        data << [_('Servicios Sanitarios'),
          print_boolean(@report.medical_record.sanitary_services)]
        data << [_('Servicios Sociales'),
          print_boolean(@report.medical_record.social_services)]
        data << [_('Servicios Educativos'),
          print_boolean(@report.medical_record.educative_services)]

        print_table(data)
        data = []
      end
    end

    if @report.show_diagnosis_data?
      h2(_('Datos de diagnóstico'))
      if @report.show_diagnosis_created_at? && @report.odat_diagnosis.created_at
        h3(_('Fecha de creación del diagnóstico'))

        data << [_('Fecha de creación'),
          l(@report.odat_diagnosis.created_at.to_date)]
        print_table(data)
        data = []
      end
      if @report.show_consultation_details?
        h3(_('Datos de demanda'))

        if @report.odat_diagnosis.origin_source
          data << [_('Fuente de derivación'),
            h(@report.odat_diagnosis.origin_source.name)]
        end

        if @report.odat_diagnosis.origin_cause
          data << [_('Motivo de derivación'),
            h(@report.odat_diagnosis.origin_cause.name)]
        end

        if @report.odat_diagnosis.consultation_cause
          data << [_('Motivo de consulta expresado por los padres'),
            h(@report.odat_diagnosis.consultation_cause.name)]
        end

        data << [_('Denominación'),
          h(@report.odat_diagnosis.description)]

        print_table(data)
        data = []
      end

      if @report.show_center_resources?
        h3(_('Datos de centro'))

        for resource in @report.odat_diagnosis.center_resources do
          text "<indent/>&bull; " << h(resource.name)
        end

        move_down 30

      end

      if @report.show_main_diagnosis?
        h3(_('Diagnóstico principal'))
        if @report.odat_diagnosis.main_diagnosis
          text h(@report.odat_diagnosis.main_diagnosis.name)
        else
          text _('No se ha indicado un diagnóstico principal.')
        end
        move_down 30
      end

      if @report.show_detailed_diagnosis?
        h3(_('Datos de diagnóstico'))

        for cat in DiagnosisItem.roots
          if cat.is_ancestor_of_any?(@report.odat_diagnosis.diagnosis_items)
            text "<strong> &bull; #{h(cat.name)}</strong>"

            for subcat in cat.children
              if subcat.is_ancestor_of_any?(@report.odat_diagnosis.diagnosis_items)
                move_down 10
                text "<indent/> &bull; #{h(subcat.name)}"

                for item in subcat.children
                  if item.is_ancestor_of_any?(@report.odat_diagnosis.diagnosis_items)
                    text "<indent/><indent/> &bull; #{h(item.name)}"
                  end
                end

              end
            end
            move_down 30

          end
        end

      end

    end

    if @report.show_report_data?
      h2(_('Informe'))
      if @report.show_topic?
        h3(_('Asunto'))
        text @report.topic_html
        move_down 30
      end
      if @report.show_tests?
        h3(_('Pruebas'))
        text @report.tests_html
        move_down 30
      end
      if @report.show_results?
        h3(_('Resultados'))
        text @report.results_html
        move_down 30
      end
      if @report.show_orientation?
        h3(_('Orientaciones'))
        text @report.orientation_html
        move_down 30
      end

    end

    move_down 30

    if @report.show_signed_on? and @report.signed_on
      text l(@report.signed_on.to_date, :format => :long), :align => :right
      move_down 10
    end
    if @report.show_signature?
      text h(@report.signature), :align => :right
      move_down 30
    end
  end
end
