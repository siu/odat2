# encoding: UTF-8
class CenterReportsController < ApplicationController
  layout :get_layout

  # GET /center_reports
  # GET /center_reports.xml
  def index
    @center_reports = current_user.center.center_reports.paginate(
      :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @center_reports }
    end
  end

  # GET /center_reports/1
  # GET /center_reports/1.xml
  def show
    @center_report = current_user.center.center_reports.find(params[:id])
    @center_report.items = current_user.center.medical_records

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @center_report }
      format.pdf do
        output = @center_report.to_pdf
        send_data output, 
          :filename => "ODAT-#{_('informe_centro')}_#{current_user.center.id}_#{@center_report.id}.pdf", 
          :type => "application/pdf"
      end
    end
  end

  # GET /center_reports/new
  # GET /center_reports/new.xml
  def new
    @center_report = create_center_report(current_user.center_id)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @center_report }
    end
  end

  # GET /center_reports/1/edit
  def edit
    @center_report = current_user.center.center_reports.find(params[:id])
  end

  # POST /center_reports
  # POST /center_reports.xml
  def create
    @center_report = create_center_report(current_user.center_id)
    @center_report.update_attributes(params[:center_report])

    respond_to do |format|
      if @center_report.save
        format.html { 
          flash[:notice] = _('El nuevo informe de centro se ha almacenado con éxito')
          redirect_to(@center_report) 
        }
        format.xml  { render :xml => @center_report, :status => :created, :location => @center_report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @center_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /center_reports/1
  # PUT /center_reports/1.xml
  def update
    @center_report = current_user.center.center_reports.find(params[:id])

    respond_to do |format|
      if @center_report.update_attributes(params[:center_report])
        format.html { 
          flash[:notice] = _('Las modificaciones se han guardado correctamente')
          redirect_to(@center_report) 
        }
        format.js
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @center_report.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /center_reports/1
  # DELETE /center_reports/1.xml
  def destroy
    @center_report = current_user.center.center_reports.find(params[:id])
    @center_report.destroy

    respond_to do |format|
      format.html { 
        flash[:notice] = _('Se ha eliminado el informe correctamente')
        redirect_to(center_reports_url) 
      }
      format.xml  { head :ok }
    end
  end

protected

  def create_center_report(center_id)
    o = CenterReport.new(
      :comparative_report_template_id => 
        ComparativeReportTemplate.find_by_name('center').id,
      :center_id => center_id)
    o
  end
  
  def get_layout
    if ['index', 'new', 'create'].include?request[:action]
      'application'
    else
      'center_reports'
    end
  end
end
