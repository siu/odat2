# encoding: UTF-8
class Admin::ReportFieldTemplatesController < Admin::AdminSectionController
  # GET /report_field_templates
  # GET /report_field_templates.xml
  def index
    @report_field_templates = ReportFieldTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @report_field_templates }
    end
  end

  # GET /report_field_templates/1
  # GET /report_field_templates/1.xml
  def show
    @report_field_template = ReportFieldTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report_field_template }
    end
  end

  # GET /report_field_templates/new
  # GET /report_field_templates/new.xml
  def new
    @report_field_template = ReportFieldTemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @report_field_template }
    end
  end

  # GET /report_field_templates/1/edit
  def edit
    @report_field_template = ReportFieldTemplate.find(params[:id])
  end

  # POST /report_field_templates
  # POST /report_field_templates.xml
  def create
    @report_field_template = ReportFieldTemplate.new(params[:report_field_template])

    respond_to do |format|
      if @report_field_template.save
        flash[:notice] = 'ReportFieldTemplate was successfully created.'
        format.html { redirect_to(@report_field_template) }
        format.xml  { render :xml => @report_field_template, :status => :created, :location => @report_field_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @report_field_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /report_field_templates/1
  # PUT /report_field_templates/1.xml
  def update
    @report_field_template = ReportFieldTemplate.find(params[:id])

    respond_to do |format|
      if @report_field_template.update_attributes(params[:report_field_template])
        flash[:notice] = 'ReportFieldTemplate was successfully updated.'
        format.html { redirect_to(@report_field_template) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report_field_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /report_field_templates/1
  # DELETE /report_field_templates/1.xml
  def destroy
    @report_field_template = ReportFieldTemplate.find(params[:id])
    @report_field_template.destroy

    respond_to do |format|
      format.html { redirect_to(report_field_templates_url) }
      format.xml  { head :ok }
    end
  end
end
