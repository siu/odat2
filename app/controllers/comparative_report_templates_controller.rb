class ComparativeReportTemplatesController < ApplicationController
  # GET /comparative_report_templates
  # GET /comparative_report_templates.xml
  def index
    @comparative_report_templates = ComparativeReportTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comparative_report_templates }
    end
  end

  # GET /comparative_report_templates/1
  # GET /comparative_report_templates/1.xml
  def show
    @comparative_report_template = ComparativeReportTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comparative_report_template }
    end
  end

  # GET /comparative_report_templates/new
  # GET /comparative_report_templates/new.xml
  def new
    @comparative_report_template = ComparativeReportTemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comparative_report_template }
    end
  end

  # GET /comparative_report_templates/1/edit
  def edit
    @comparative_report_template = ComparativeReportTemplate.find(params[:id])
  end

  # POST /comparative_report_templates
  # POST /comparative_report_templates.xml
  def create
    @comparative_report_template = ComparativeReportTemplate.new(params[:comparative_report_template])

    respond_to do |format|
      if @comparative_report_template.save
        flash[:notice] = 'ComparativeReportTemplate was successfully created.'
        format.html { redirect_to(@comparative_report_template) }
        format.xml  { render :xml => @comparative_report_template, :status => :created, :location => @comparative_report_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comparative_report_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comparative_report_templates/1
  # PUT /comparative_report_templates/1.xml
  def update
    @comparative_report_template = ComparativeReportTemplate.find(params[:id])

    respond_to do |format|
      if @comparative_report_template.update_attributes(params[:comparative_report_template])
        flash[:notice] = 'ComparativeReportTemplate was successfully updated.'
        format.html { redirect_to(@comparative_report_template) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comparative_report_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comparative_report_templates/1
  # DELETE /comparative_report_templates/1.xml
  def destroy
    @comparative_report_template = ComparativeReportTemplate.find(params[:id])
    @comparative_report_template.destroy

    respond_to do |format|
      format.html { redirect_to(comparative_report_templates_url) }
      format.xml  { head :ok }
    end
  end
end
