class OdatDiagnosesController < ApplicationController
  before_filter :load_medical_record

  def load_medical_record
    @medical_record = MedicalRecord.find(params[:medical_record_id])
  end

  # GET /odat_diagnoses
  # GET /odat_diagnoses.xml
  def index
    @odat_diagnoses = OdatDiagnosis.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @odat_diagnoses }
    end
  end

  # GET /odat_diagnoses/1
  # GET /odat_diagnoses/1.xml
  def show
    @odat_diagnosis = OdatDiagnosis.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @odat_diagnosis }
    end
  end

  # GET /odat_diagnoses/new
  # GET /odat_diagnoses/new.xml
  def new
    @odat_diagnosis = OdatDiagnosis.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @odat_diagnosis }
    end
  end

  # GET /odat_diagnoses/1/edit
  def edit
    @odat_diagnosis = OdatDiagnosis.find(params[:id])
  end

  # POST /odat_diagnoses
  # POST /odat_diagnoses.xml
  def create
    @odat_diagnosis = OdatDiagnosis.new(params[:odat_diagnosis])

    respond_to do |format|
      if @odat_diagnosis.save
        flash[:notice] = 'OdatDiagnosis was successfully created.'
        format.html { redirect_to(@medical_record, @odat_diagnosis) }
        format.xml  { render :xml => @odat_diagnosis, :status => :created, :location => @odat_diagnosis }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @odat_diagnosis.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /odat_diagnoses/1
  # PUT /odat_diagnoses/1.xml
  def update
    @odat_diagnosis = OdatDiagnosis.find(params[:id])

    respond_to do |format|
      if @odat_diagnosis.update_attributes(params[:odat_diagnosis])
        flash[:notice] = 'OdatDiagnosis was successfully updated.'
        format.html { redirect_to(@medical_record, @odat_diagnosis) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @odat_diagnosis.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /odat_diagnoses/1
  # DELETE /odat_diagnoses/1.xml
  def destroy
    @odat_diagnosis = OdatDiagnosis.find(params[:id])
    @odat_diagnosis.destroy

    respond_to do |format|
      format.html { redirect_to(medical_record_odat_diagnoses_url(
				:medical_record_id => @medical_record.id)) }
      format.xml  { head :ok }
    end
  end
end
