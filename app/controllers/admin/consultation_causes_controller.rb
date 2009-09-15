# encoding: UTF-8
class Admin::ConsultationCausesController  < Admin::AdminSectionController
  # GET /consultation_causes
  # GET /consultation_causes.xml
  def index
    @consultation_causes = ConsultationCause.paginate(
      :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @consultation_causes }
    end
  end

  # GET /consultation_causes/1
  # GET /consultation_causes/1.xml
  def show
    @consultation_cause = ConsultationCause.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @consultation_cause }
    end
  end

  # GET /consultation_causes/new
  # GET /consultation_causes/new.xml
  def new
    @consultation_cause = ConsultationCause.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @consultation_cause }
    end
  end

  # GET /consultation_causes/1/edit
  def edit
    @consultation_cause = ConsultationCause.find(params[:id])
  end

  # POST /consultation_causes
  # POST /consultation_causes.xml
  def create
    @consultation_cause = ConsultationCause.new(params[:consultation_cause])

    respond_to do |format|
      if @consultation_cause.save
        flash[:notice] = 'ConsultationCause was successfully created.'
        format.html { redirect_to([:admin, @consultation_cause]) }
        format.xml  { render :xml => @consultation_cause, :status => :created, :location => @consultation_cause }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @consultation_cause.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /consultation_causes/1
  # PUT /consultation_causes/1.xml
  def update
    @consultation_cause = ConsultationCause.find(params[:id])

    respond_to do |format|
      if @consultation_cause.update_attributes(params[:consultation_cause])
        flash[:notice] = 'ConsultationCause was successfully updated.'
        format.html { redirect_to([:admin, @consultation_cause]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @consultation_cause.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /consultation_causes/1
  # DELETE /consultation_causes/1.xml
  def destroy
    @consultation_cause = ConsultationCause.find(params[:id])
    @consultation_cause.destroy

    respond_to do |format|
      format.html { redirect_to(admin_consultation_causes_url) }
      format.xml  { head :ok }
    end
  end
end
