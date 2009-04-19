class OdatDiagnosesController < ApplicationController
  before_filter :load_medical_record

  # GET /odat_diagnoses
  # GET /odat_diagnoses.xml
  def index
    @odat_diagnoses = @medical_record.odat_diagnoses

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @odat_diagnoses }
    end
  end

  # GET /odat_diagnoses/1
  # GET /odat_diagnoses/1.xml
  def show
    @odat_diagnosis = @medical_record.odat_diagnoses.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @odat_diagnosis }
    end
  end

  # GET /odat_diagnoses/new
  # GET /odat_diagnoses/new.xml
  def new
    @odat_diagnosis = @medical_record.odat_diagnoses.build
    load_form_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @odat_diagnosis }
    end
  end

  # GET /odat_diagnoses/1/edit
  def edit
    @odat_diagnosis = @medical_record.odat_diagnoses.find(params[:id])
    load_form_data
  end

  # POST /odat_diagnoses
  # POST /odat_diagnoses.xml
  def create
    params[:odat_diagnosis].reverse_merge!(:created_at => Time.now)
    @odat_diagnosis = @medical_record.odat_diagnoses.build(
      attributes = params[:odat_diagnosis])

    respond_to do |format|
      if @odat_diagnosis.save
        flash[:notice] = 'OdatDiagnosis was successfully created.'
        format.html { redirect_to(medical_record_odat_diagnoses_path(@medical_record)) }
        format.xml  { 
	  render :xml => @odat_diagnosis, 
	  :status => :created, 
	  :location => @odat_diagnosis 
	}
      else
        format.html { 
	  load_form_data
	  render :action => "new" }
        format.xml  { 
	  render :xml => @odat_diagnosis.errors, 
	  :status => :unprocessable_entity 
	}
      end
    end
  end

  # PUT /odat_diagnoses/1
  # PUT /odat_diagnoses/1.xml
  def update
    params[:odat_diagnosis][:diagnosis_item_ids] ||= []
    params[:odat_diagnosis][:center_resource_ids] ||= []
    @odat_diagnosis = @medical_record.odat_diagnoses.find(params[:id])

    respond_to do |format|
      if @odat_diagnosis.update_attributes(params[:odat_diagnosis])
        flash[:notice] = 'OdatDiagnosis was successfully updated.'
        format.html { redirect_to(medical_record_odat_diagnoses_path(@medical_record)) }
        format.xml  { head :ok }
      else
        format.html { 
	  load_form_data
	  render :action => "edit" }
        format.xml  { 
	  render :xml => @odat_diagnosis.errors, 
	  :status => :unprocessable_entity 
	}
      end
    end
  end

  # DELETE /odat_diagnoses/1
  # DELETE /odat_diagnoses/1.xml
  def destroy
    @odat_diagnosis = @medical_record.odat_diagnoses.find(params[:id])
    @odat_diagnosis.destroy

    respond_to do |format|
      format.html { redirect_to(medical_record_odat_diagnoses_path(
				@medical_record)) }
      format.xml  { head :ok }
    end
  end

protected
  def load_medical_record
    @medical_record = 
      current_user.medical_records.find(params[:medical_record_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to medical_records_path
  end

  def load_form_data
    @origin_sources = OriginSource.find(:all, :order => 'name ASC')
    @origin_causes = OriginCause.find(:all, :order => 'name ASC')
    @consultation_causes = ConsultationCause.find(:all, :order => 'name ASC')
  end
end
