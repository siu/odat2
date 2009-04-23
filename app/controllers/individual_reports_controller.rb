class IndividualReportsController < ApplicationController
  # GET /individual_reports
  # GET /individual_reports.xml
  def index
    @individual_reports = IndividualReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @individual_reports }
    end
  end

  # GET /individual_reports/1
  # GET /individual_reports/1.xml
  def show
    @individual_report = IndividualReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @individual_report }
    end
  end

  # GET /individual_reports/new
  # GET /individual_reports/new.xml
  def new
    @individual_report = IndividualReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @individual_report }
    end
  end

  # GET /individual_reports/1/edit
  def edit
    @individual_report = IndividualReport.find(params[:id])
  end

  # POST /individual_reports
  # POST /individual_reports.xml
  def create
    @individual_report = IndividualReport.new(params[:individual_report])

    respond_to do |format|
      if @individual_report.save
        flash[:notice] = 'IndividualReport was successfully created.'
        format.html { redirect_to(@individual_report) }
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
    @individual_report = IndividualReport.find(params[:id])

    respond_to do |format|
      if @individual_report.update_attributes(params[:individual_report])
        flash[:notice] = 'IndividualReport was successfully updated.'
        format.html { redirect_to(@individual_report) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @individual_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /individual_reports/1
  # DELETE /individual_reports/1.xml
  def destroy
    @individual_report = IndividualReport.find(params[:id])
    @individual_report.destroy

    respond_to do |format|
      format.html { redirect_to(individual_reports_url) }
      format.xml  { head :ok }
    end
  end
end