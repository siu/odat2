class ComparativeReportsController < ApplicationController
  # GET /comparative_reports
  # GET /comparative_reports.xml
  def index
    @comparative_reports = ComparativeReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comparative_reports }
    end
  end

  # GET /comparative_reports/1
  # GET /comparative_reports/1.xml
  def show
    @comparative_report = ComparativeReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comparative_report }
    end
  end

  # GET /comparative_reports/new
  # GET /comparative_reports/new.xml
  def new
    @comparative_report = ComparativeReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comparative_report }
    end
  end

  # GET /comparative_reports/1/edit
  def edit
    @comparative_report = ComparativeReport.find(params[:id])
  end

  # POST /comparative_reports
  # POST /comparative_reports.xml
  def create
    @comparative_report = ComparativeReport.new(params[:comparative_report])

    respond_to do |format|
      if @comparative_report.save
        flash[:notice] = 'ComparativeReport was successfully created.'
        format.html { redirect_to(@comparative_report) }
        format.xml  { render :xml => @comparative_report, :status => :created, :location => @comparative_report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comparative_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comparative_reports/1
  # PUT /comparative_reports/1.xml
  def update
    @comparative_report = ComparativeReport.find(params[:id])

    respond_to do |format|
      if @comparative_report.update_attributes(params[:comparative_report])
        flash[:notice] = 'ComparativeReport was successfully updated.'
        format.html { redirect_to(@comparative_report) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comparative_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comparative_reports/1
  # DELETE /comparative_reports/1.xml
  def destroy
    @comparative_report = ComparativeReport.find(params[:id])
    @comparative_report.destroy

    respond_to do |format|
      format.html { redirect_to(comparative_reports_url) }
      format.xml  { head :ok }
    end
  end
end
