# encoding: UTF-8
class Admin::SchoolTypesController < Admin::AdminSectionController
  # GET /school_types
  # GET /school_types.xml
  def index
    @school_types = SchoolType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @school_types }
    end
  end

  # GET /school_types/1
  # GET /school_types/1.xml
  def show
    @school_type = SchoolType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @school_type }
    end
  end

  # GET /school_types/new
  # GET /school_types/new.xml
  def new
    @school_type = SchoolType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @school_type }
    end
  end

  # GET /school_types/1/edit
  def edit
    @school_type = SchoolType.find(params[:id])
  end

  # POST /school_types
  # POST /school_types.xml
  def create
    @school_type = SchoolType.new(params[:school_type])

    respond_to do |format|
      if @school_type.save
        flash[:notice] = 'SchoolType was successfully created.'
        format.html { redirect_to(@school_type) }
        format.xml  { render :xml => @school_type, :status => :created, :location => @school_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @school_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /school_types/1
  # PUT /school_types/1.xml
  def update
    @school_type = SchoolType.find(params[:id])

    respond_to do |format|
      if @school_type.update_attributes(params[:school_type])
        flash[:notice] = 'SchoolType was successfully updated.'
        format.html { redirect_to(@school_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @school_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /school_types/1
  # DELETE /school_types/1.xml
  def destroy
    @school_type = SchoolType.find(params[:id])
    @school_type.destroy

    respond_to do |format|
      format.html { redirect_to(school_types_url) }
      format.xml  { head :ok }
    end
  end
end
