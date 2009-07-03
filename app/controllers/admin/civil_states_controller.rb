class Admin::CivilStatesController < Admin::AdminSectionController
  # GET /civil_states
  # GET /civil_states.xml
  def index
    @civil_states = CivilState.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @civil_states }
    end
  end

  # GET /civil_states/1
  # GET /civil_states/1.xml
  def show
    @civil_state = CivilState.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @civil_state }
    end
  end

  # GET /civil_states/new
  # GET /civil_states/new.xml
  def new
    @civil_state = CivilState.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @civil_state }
    end
  end

  # GET /civil_states/1/edit
  def edit
    @civil_state = CivilState.find(params[:id])
  end

  # POST /civil_states
  # POST /civil_states.xml
  def create
    @civil_state = CivilState.new(params[:civil_state])

    respond_to do |format|
      if @civil_state.save
        flash[:notice] = 'CivilState was successfully created.'
        format.html { redirect_to([:admin, @civil_state]) }
        format.xml  { render :xml => @civil_state, :status => :created, :location => @civil_state }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @civil_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /civil_states/1
  # PUT /civil_states/1.xml
  def update
    @civil_state = CivilState.find(params[:id])

    respond_to do |format|
      if @civil_state.update_attributes(params[:civil_state])
        flash[:notice] = 'CivilState was successfully updated.'
        format.html { redirect_to([:admin, @civil_state]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @civil_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /civil_states/1
  # DELETE /civil_states/1.xml
  def destroy
    @civil_state = CivilState.find(params[:id])
    @civil_state.destroy

    respond_to do |format|
      format.html { redirect_to(admin_civil_states_url) }
      format.xml  { head :ok }
    end
  end
end
