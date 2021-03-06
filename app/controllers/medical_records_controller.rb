# encoding: UTF-8
class MedicalRecordsController < ApplicationController
  layout :get_layout

  # GET /medical_records
  # GET /medical_records.xml
  # GET /medical_records.csv?style=default
  def index
    @medical_records = current_user.medical_records.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @medical_records }
      format.csv  do
        @medical_records = current_user.medical_records
        render( :csv => @medical_records, :style => (params[:style] || :default).to_sym, :force_quotes => true )
      end
    end
  end

  # GET /medical_records/1
  # GET /medical_records/1.xml
  # GET /medical_records/1.csv?style=default
  def show
    @medical_record = current_user.medical_records.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @medical_record }
      format.csv  { render :csv => @medical_record, :style => (params[:style] || :default).to_sym, :force_quotes => true }
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to medical_records_path
  end

  # GET /medical_records/new
  # GET /medical_records/new.xml
  def new
    load_data
    @medical_record = MedicalRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @medical_record }
    end
  end

  # GET /medical_records/1/edit
  def edit
    load_data
    @medical_record = current_user.medical_records.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to medical_records_path
  end

  # POST /medical_records
  # POST /medical_records.xml
  def create
    @medical_record = MedicalRecord.new(params[:medical_record])
    @medical_record.center_id = current_user.center_id

    respond_to do |format|
      if @medical_record.save
        flash[:notice] = _('El nuevo expediente se ha almacenado con éxito')
        format.html { redirect_to(@medical_record) }
        format.xml  { render :xml => @medical_record, 
	  :status => :created, 
	  :location => @medical_record }
      else
        format.html do 
	  load_data
	  render :action => "new" 
	end
        format.xml  { render :xml => @medical_record.errors, 
	  :status => :unprocessable_entity }
      end
    end
  end

  # PUT /medical_records/1
  # PUT /medical_records/1.xml
  def update
    @medical_record = current_user.medical_records.find(params[:id])

    respond_to do |format|
      if @medical_record.update_attributes(params[:medical_record])
        flash[:notice] = _('Las modificaciones se han guardado correctamente')
        format.html { redirect_to(@medical_record) }
        format.xml  { head :ok }
      else
        format.html do
	  load_data
	  render :action => "edit" 
	end
        format.xml  { render :xml => @medical_record.errors, 
	  :status => :unprocessable_entity }
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to medical_records_path
  end

  # DELETE /medical_records/1
  # DELETE /medical_records/1.xml
  def destroy
    @medical_record = current_user.medical_records.find(params[:id])
    @medical_record.destroy

    respond_to do |format|
      format.html { 
        flash[:notice] = _('Se ha eliminado el expediente para %{name} correctamente') % {:name => @medical_record.full_name}
        redirect_to(medical_records_url) 
      }
      format.xml  { head :ok }
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to medical_records_path
  end

protected

  def load_data
    @provinces = Province.find(:all)
    @genders = [_('Masculino'), _('Femenino')]
    @formation_levels = FormationLevel.find(:all)
    @jobs = Job.find(:all)
    @job_statuses = JobStatus.find(:all)
    @civil_states = CivilState.find(:all)
  end

  def get_layout
    if ['index', 'new', 'create'].include?request[:action]
      'application'
    else
      'medical_records'
    end
  end

end
