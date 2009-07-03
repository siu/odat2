class Admin::DiagnosisItemsController < Admin::AdminSectionController
  # GET /diagnosis_items
  # GET /diagnosis_items.xml
  def index
    @diagnosis_items = DiagnosisItem.paginate(
      :page => params[:page], 
      :order => 'name ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @diagnosis_items }
    end
  end

  # GET /diagnosis_items/1
  # GET /diagnosis_items/1.xml
  def show
    @diagnosis_item = DiagnosisItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @diagnosis_item }
    end
  end

  # GET /help/diagnosis_items
  # GET /help/diagnosis_items.xml
  def help_index
    @diagnosis_items = DiagnosisItem.categories

    respond_to do |format|
      format.html { render :layout => 'help/help_layout' }
      format.xml  { render :xml => @diagnosis_items }
    end
  end
  # GET /diagnosis_items/1
  # GET /diagnosis_items/1.xml
  def help
    @diagnosis_item = DiagnosisItem.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'help/help_layout' }
      format.xml  { render :xml => @diagnosis_item }
    end
  end

  # GET /diagnosis_items/new
  # GET /diagnosis_items/new.xml
  def new
    @diagnosis_item = DiagnosisItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @diagnosis_item }
    end
  end

  # GET /diagnosis_items/1/edit
  def edit
    @diagnosis_item = DiagnosisItem.find(params[:id])
  end

  # POST /diagnosis_items
  # POST /diagnosis_items.xml
  def create
    @diagnosis_item = DiagnosisItem.new(params[:diagnosis_item])

    respond_to do |format|
      if @diagnosis_item.save
        flash[:notice] = 'DiagnosisItem was successfully created.'
        format.html { redirect_to([:admin, @diagnosis_item]) }
        format.xml  { render :xml => @diagnosis_item, :status => :created, :location => @diagnosis_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @diagnosis_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /diagnosis_items/1
  # PUT /diagnosis_items/1.xml
  def update
    @diagnosis_item = DiagnosisItem.find(params[:id])

    respond_to do |format|
      if @diagnosis_item.update_attributes(params[:diagnosis_item])
        flash[:notice] = 'DiagnosisItem was successfully updated.'
        format.html { redirect_to([:admin, @diagnosis_item]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @diagnosis_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /diagnosis_items/1
  # DELETE /diagnosis_items/1.xml
  def destroy
    @diagnosis_item = DiagnosisItem.find(params[:id])
    @diagnosis_item.destroy

    respond_to do |format|
      format.html { redirect_to(admin_diagnosis_items_url) }
      format.xml  { head :ok }
    end
  end
end
