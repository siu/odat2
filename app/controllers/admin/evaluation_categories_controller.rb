class Admin::EvaluationCategoriesController < Admin::AdminSectionController
  # GET /admin/evaluation_categories
  # GET /admin/evaluation_categories.xml
  def index
    @evaluation_categories = EvaluationCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @evaluation_categories }
    end
  end

  # GET /admin/evaluation_categories/1
  # GET /admin/evaluation_categories/1.xml
  def show
    @evaluation_category = EvaluationCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @evaluation_category }
    end
  end

  # GET /admin/evaluation_categories/new
  # GET /admin/evaluation_categories/new.xml
  def new
    @evaluation_category = EvaluationCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @evaluation_category }
    end
  end

  # GET /admin/evaluation_categories/1/edit
  def edit
    @evaluation_category = EvaluationCategory.find(params[:id])
  end

  # POST /admin/evaluation_categories
  # POST /admin/evaluation_categories.xml
  def create
    @evaluation_category = EvaluationCategory.new(params[:evaluation_category])

    respond_to do |format|
      if @evaluation_category.save
        flash[:notice] = 'EvaluationCategory was successfully created.'
        format.html { redirect_to(@evaluation_category) }
        format.xml  { render :xml => @evaluation_category, :status => :created, :location => @evaluation_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @evaluation_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/evaluation_categories/1
  # PUT /admin/evaluation_categories/1.xml
  def update
    @evaluation_category = EvaluationCategory.find(params[:id])

    respond_to do |format|
      if @evaluation_category.update_attributes(params[:evaluation_category])
        flash[:notice] = 'EvaluationCategory was successfully updated.'
        format.html { redirect_to(@evaluation_category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @evaluation_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/evaluation_categories/1
  # DELETE /admin/evaluation_categories/1.xml
  def destroy
    @evaluation_category = EvaluationCategory.find(params[:id])
    @evaluation_category.destroy

    respond_to do |format|
      format.html { redirect_to(evaluation_categories_url) }
      format.xml  { head :ok }
    end
  end
end
