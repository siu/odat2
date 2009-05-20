class Admin::RegionsController < Admin::AdminSectionController

  # load data
  before_filter :new_region, :only => [:new, :create]
  before_filter :load_region, :only => [:show, :edit, :update, :destroy]
  before_filter :load_regions, :only => [:index]

  # render templates
  before_filter :show_regions, :only => [:index]
  before_filter :show_region, :only => [:show, :new]

  # GET /regions
  # GET /regions.xml
  def index; end

  # GET /regions/1
  # GET /regions/1.xml
  def show; end

  # GET /regions/new
  # GET /regions/new.xml
  def new; end

  # GET /regions/1/edit
  def edit; end

  # POST /regions
  # POST /regions.xml
  def create
    @region.attributes = params[:region]
    respond_to do |format|
      if @region.save
        flash[:notice] = 'Region was successfully created.'
        format.html { redirect_to([:admin, @region]) }
        format.xml  { render :xml => @region, 
          :status => :created, :location => @region }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @region.errors, 
          :status => :unprocessable_entity }
      end
    end
  end

  # PUT /regions/1 # PUT /regions/1.xml
  def update
    respond_to do |format|
      if @region.update_attributes(params[:region])
        flash[:notice] = 'Region was successfully updated.'
        format.html { redirect_to([:admin, @region]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @region.errors, 
          :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /regions/1
  # DELETE /regions/1.xml
  def destroy
    @region.destroy

    respond_to do |format|
      format.html { redirect_to(admin_regions_url) }
      format.xml  { head :ok }
    end
  end


  protected

  # Load data

  def load_regions
    @regions = Region.paginate(:page => params[:page])
  end

  def load_region
    @region = Region.find(params[:id])
  end

  def new_region
    @region = Region.new
  end

  # Render templates

  def show_region
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @region }
    end
  end

  def show_regions
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @regions }
    end
  end

end
