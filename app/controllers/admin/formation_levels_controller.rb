class Admin::FormationLevelsController < ApplicationController
  # GET /formation_levels
  # GET /formation_levels.xml
  def index
    @formation_levels = FormationLevel.paginate(
      :page => params[:page], 
      :order => 'name ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @formation_levels }
    end
  end

  # GET /formation_levels/1
  # GET /formation_levels/1.xml
  def show
    @formation_level = FormationLevel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @formation_level }
    end
  end

  # GET /formation_levels/new
  # GET /formation_levels/new.xml
  def new
    @formation_level = FormationLevel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @formation_level }
    end
  end

  # GET /formation_levels/1/edit
  def edit
    @formation_level = FormationLevel.find(params[:id])
  end

  # POST /formation_levels
  # POST /formation_levels.xml
  def create
    @formation_level = FormationLevel.new(params[:formation_level])

    respond_to do |format|
      if @formation_level.save
        flash[:notice] = 'FormationLevel was successfully created.'
        format.html { redirect_to([:admin, @formation_level]) }
        format.xml  { render :xml => @formation_level, :status => :created, :location => @formation_level }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @formation_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /formation_levels/1
  # PUT /formation_levels/1.xml
  def update
    @formation_level = FormationLevel.find(params[:id])

    respond_to do |format|
      if @formation_level.update_attributes(params[:formation_level])
        flash[:notice] = 'FormationLevel was successfully updated.'
        format.html { redirect_to([:admin, @formation_level]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @formation_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /formation_levels/1
  # DELETE /formation_levels/1.xml
  def destroy
    @formation_level = FormationLevel.find(params[:id])
    @formation_level.destroy

    respond_to do |format|
      format.html { redirect_to(admin_formation_levels_url) }
      format.xml  { head :ok }
    end
  end
end
