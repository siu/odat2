class MedicalRecordsController < ApplicationController
  # GET /medical_records
  # GET /medical_records.xml
  def index
    #@medical_records = MedicalRecord.find(:all)
    @medical_records = MedicalRecord.paginate(:page => params[:page], :order => 'surname ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @medical_records }
    end
  end

  # GET /medical_records/1
  # GET /medical_records/1.xml
  def show
    @medical_record = MedicalRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @medical_record }
    end
  end

  # GET /medical_records/new
  # GET /medical_records/new.xml
  def new
    @medical_record = MedicalRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @medical_record }
    end
  end

  # GET /medical_records/1/edit
  def edit
    @medical_record = MedicalRecord.find(params[:id])
  end

  # POST /medical_records
  # POST /medical_records.xml
  def create
    @medical_record = MedicalRecord.new(params[:medical_record])

    respond_to do |format|
      if @medical_record.save
        flash[:notice] = 'MedicalRecord was successfully created.'
        format.html { redirect_to(@medical_record) }
        format.xml  { render :xml => @medical_record, :status => :created, :location => @medical_record }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @medical_record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /medical_records/1
  # PUT /medical_records/1.xml
  def update
    @medical_record = MedicalRecord.find(params[:id])

    respond_to do |format|
      if @medical_record.update_attributes(params[:medical_record])
        flash[:notice] = 'MedicalRecord was successfully updated.'
        format.html { redirect_to(@medical_record) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @medical_record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /medical_records/1
  # DELETE /medical_records/1.xml
  def destroy
    @medical_record = MedicalRecord.find(params[:id])
    @medical_record.destroy

    respond_to do |format|
      format.html { redirect_to(medical_records_url) }
      format.xml  { head :ok }
    end
  end
end
