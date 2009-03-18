class Admin::OriginSourcesController < Admin::AdminSectionController
  # GET /origin_sources
  # GET /origin_sources.xml
  def index
    @origin_sources = OriginSource.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @origin_sources }
    end
  end

  # GET /origin_sources/1
  # GET /origin_sources/1.xml
  def show
    @origin_source = OriginSource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @origin_source }
    end
  end

  # GET /origin_sources/new
  # GET /origin_sources/new.xml
  def new
    @origin_source = OriginSource.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @origin_source }
    end
  end

  # GET /origin_sources/1/edit
  def edit
    @origin_source = OriginSource.find(params[:id])
  end

  # POST /origin_sources
  # POST /origin_sources.xml
  def create
    @origin_source = OriginSource.new(params[:origin_source])

    respond_to do |format|
      if @origin_source.save
        flash[:notice] = 'OriginSource was successfully created.'
        format.html { redirect_to([:admin, @origin_source]) }
        format.xml  { render :xml => @origin_source, :status => :created, :location => @origin_source }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @origin_source.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /origin_sources/1
  # PUT /origin_sources/1.xml
  def update
    @origin_source = OriginSource.find(params[:id])

    respond_to do |format|
      if @origin_source.update_attributes(params[:origin_source])
        flash[:notice] = 'OriginSource was successfully updated.'
        format.html { redirect_to([:admin, @origin_source]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @origin_source.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /origin_sources/1
  # DELETE /origin_sources/1.xml
  def destroy
    @origin_source = OriginSource.find(params[:id])
    @origin_source.destroy

    respond_to do |format|
      format.html { redirect_to(admin_origin_sources_url) }
      format.xml  { head :ok }
    end
  end
end
