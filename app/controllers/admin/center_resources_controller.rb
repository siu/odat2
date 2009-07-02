class Admin::CenterResourcesController < Admin::AdminSectionController
  # GET /center_resources
  # GET /center_resources.xml
  def index
    @center_resources = CenterResource.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @center_resources }
    end
  end

  # GET /center_resources/1
  # GET /center_resources/1.xml
  def show
    @center_resource = CenterResource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @center_resource }
    end
  end

  # GET /center_resources
  # GET /center_resources.xml
  def help_index
    @center_resources = CenterResource.all

    respond_to do |format|
      format.html { render :layout => 'help/help_layout' }
      format.xml  { render :xml => @center_resources }
    end
  end

  # GET /center_resources/1
  # GET /center_resources/1.xml
  def help
    @center_resource = CenterResource.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'help/help_layout' }
      format.xml  { render :xml => @center_resource }
    end
  end

  # GET /center_resources/new
  # GET /center_resources/new.xml
  def new
    @center_resource = CenterResource.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @center_resource }
    end
  end

  # GET /center_resources/1/edit
  def edit
    @center_resource = CenterResource.find(params[:id])
  end

  # POST /center_resources
  # POST /center_resources.xml
  def create
    @center_resource = CenterResource.new(params[:center_resource])

    respond_to do |format|
      if @center_resource.save
        flash[:notice] = 'CenterResource was successfully created.'
        format.html { redirect_to([:admin,@center_resource]) }
        format.xml  { render :xml => @center_resource, :status => :created, :location => @center_resource }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @center_resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /center_resources/1
  # PUT /center_resources/1.xml
  def update
    @center_resource = CenterResource.find(params[:id])

    respond_to do |format|
      if @center_resource.update_attributes(params[:center_resource])
        flash[:notice] = 'CenterResource was successfully updated.'
        format.html { redirect_to([:admin, @center_resource]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @center_resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /center_resources/1
  # DELETE /center_resources/1.xml
  def destroy
    @center_resource = CenterResource.find(params[:id])
    @center_resource.destroy

    respond_to do |format|
      format.html { redirect_to(admin_center_resources_url) }
      format.xml  { head :ok }
    end
  end
end
