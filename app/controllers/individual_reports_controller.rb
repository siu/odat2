class IndividualReportsController < ApplicationController
  layout 'medical_records'
  before_filter :load_medical_record

  # GET /individual_reports
  # GET /individual_reports.xml
  def index
    @individual_reports = @medical_record.individual_reports.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @individual_reports }
    end
  end

  # GET /individual_reports/1
  # GET /individual_reports/1.xml
  def show
    @individual_report = @medical_record.individual_reports.find(params[:id])
    @odat_diagnosis = @individual_report.odat_diagnosis

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @individual_report }
      format.pdf  { render :layout => false }
    end
  end

  # GET /individual_reports/new
  # GET /individual_reports/new.xml
  def new
    @individual_report = @medical_record.individual_reports.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @individual_report }
    end
  end

  # GET /individual_reports/1/edit
  def edit
    @individual_report = @medical_record.individual_reports.find(params[:id])
  end

  # POST /individual_reports
  # POST /individual_reports.xml
  def create
    @individual_report = @medical_record.individual_reports.new(params[:individual_report])

    respond_to do |format|
      if @individual_report.save
        flash[:notice] = _('El nuevo informe individual se ha almacenado con éxito')
        format.html { 
          redirect_to(medical_record_individual_report_path(
            :medical_record_id => @medical_record.id, 
            :id => @individual_report.id))
        }
        format.xml  { render :xml => @individual_report, :status => :created, :location => @individual_report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @individual_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /individual_reports/1
  # PUT /individual_reports/1.xml
  def update
    @individual_report = @medical_record.individual_reports.find(params[:id])

    respond_to do |format|
      if @individual_report.update_attributes(params[:individual_report])
        format.html { 
          flash[:notice] = _('Las modificaciones se han guardado correctamente')
          redirect_to(
            medical_record_individual_report_path(
              :medical_record_id => @medical_record.id,
              :id => @individual_report.id)) 
        }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @individual_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /individual_reports/1
  # DELETE /individual_reports/1.xml
  def destroy
    @individual_report = @medical_record.individual_reports.find(params[:id])
    @individual_report.destroy

    respond_to do |format|
      format.html { 
        flash[:notice] = _('Se ha eliminado el informe correctamente')
        redirect_to(medical_record_individual_reports_url) 
      }
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
end
