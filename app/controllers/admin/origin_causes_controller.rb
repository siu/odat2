class Admin::OriginCausesController < Admin::AdminSectionController
  # GET /origin_causes
  # GET /origin_causes.xml
  def index
    @origin_causes = OriginCause.paginate(
      :page => params[:page], 
      :order => 'name ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @origin_causes }
    end
  end

  # GET /origin_causes/1
  # GET /origin_causes/1.xml
  def show
    @origin_cause = OriginCause.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @origin_cause }
    end
  end

  # GET /origin_causes/new
  # GET /origin_causes/new.xml
  def new
    @origin_cause = OriginCause.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @origin_cause }
    end
  end

  # GET /origin_causes/1/edit
  def edit
    @origin_cause = OriginCause.find(params[:id])
  end

  # POST /origin_causes
  # POST /origin_causes.xml
  def create
    @origin_cause = OriginCause.new(params[:origin_cause])

    respond_to do |format|
      if @origin_cause.save
        flash[:notice] = 'OriginCause was successfully created.'
        format.html { redirect_to([:admin, @origin_cause]) }
        format.xml  { render :xml => @origin_cause, :status => :created, :location => @origin_cause }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @origin_cause.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /origin_causes/1
  # PUT /origin_causes/1.xml
  def update
    @origin_cause = OriginCause.find(params[:id])

    respond_to do |format|
      if @origin_cause.update_attributes(params[:origin_cause])
        flash[:notice] = 'OriginCause was successfully updated.'
        format.html { redirect_to([:admin, @origin_cause]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @origin_cause.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /origin_causes/1
  # DELETE /origin_causes/1.xml
  def destroy
    @origin_cause = OriginCause.find(params[:id])
    @origin_cause.destroy

    respond_to do |format|
      format.html { redirect_to(admin_origin_causes_url) }
      format.xml  { head :ok }
    end
  end
end
