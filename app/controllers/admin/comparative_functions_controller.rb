class Admin::ComparativeFunctionsController < Admin::AdminSectionController
  # GET /comparative_functions
  # GET /comparative_functions.xml
  def index
    @comparative_functions = ComparativeFunction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comparative_functions }
    end
  end

  # GET /comparative_functions/1
  # GET /comparative_functions/1.xml
  def show
    @comparative_function = ComparativeFunction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comparative_function }
    end
  end

  # GET /comparative_functions/new
  # GET /comparative_functions/new.xml
  def new
    @comparative_function = ComparativeFunction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comparative_function }
    end
  end

  # GET /comparative_functions/1/edit
  def edit
    @comparative_function = ComparativeFunction.find(params[:id])
  end

  # POST /comparative_functions
  # POST /comparative_functions.xml
  def create
    @comparative_function = ComparativeFunction.new(params[:comparative_function])

    respond_to do |format|
      if @comparative_function.save
        flash[:notice] = 'ComparativeFunction was successfully created.'
        format.html { redirect_to(@comparative_function) }
        format.xml  { render :xml => @comparative_function, :status => :created, :location => @comparative_function }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comparative_function.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comparative_functions/1
  # PUT /comparative_functions/1.xml
  def update
    @comparative_function = ComparativeFunction.find(params[:id])

    respond_to do |format|
      if @comparative_function.update_attributes(params[:comparative_function])
        flash[:notice] = 'ComparativeFunction was successfully updated.'
        format.html { redirect_to(@comparative_function) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comparative_function.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comparative_functions/1
  # DELETE /comparative_functions/1.xml
  def destroy
    @comparative_function = ComparativeFunction.find(params[:id])
    @comparative_function.destroy

    respond_to do |format|
      format.html { redirect_to(comparative_functions_url) }
      format.xml  { head :ok }
    end
  end
end
