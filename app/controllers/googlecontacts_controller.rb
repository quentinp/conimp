class GooglecontactsController < ApplicationController
  # GET /googlecontacts
  # GET /googlecontacts.xml
  def index
    @googlecontacts = Googlecontact.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @googlecontacts }
    end
  end

  # GET /googlecontacts/1
  # GET /googlecontacts/1.xml
  def show
    @googlecontact = Googlecontact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @googlecontact }
    end
  end

  # GET /googlecontacts/new
  # GET /googlecontacts/new.xml
  def new
    @googlecontact = Googlecontact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @googlecontact }
    end
  end

  # GET /googlecontacts/1/edit
  def edit
    @googlecontact = Googlecontact.find(params[:id])
  end

  # POST /googlecontacts
  # POST /googlecontacts.xml
  def create
    @googlecontact = Googlecontact.new(params[:googlecontact])

    respond_to do |format|
      if @googlecontact.save
        format.html { redirect_to(@googlecontact, :notice => 'Googlecontact was successfully created.') }
        format.xml  { render :xml => @googlecontact, :status => :created, :location => @googlecontact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @googlecontact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /googlecontacts/1
  # PUT /googlecontacts/1.xml
  def update
    @googlecontact = Googlecontact.find(params[:id])

    respond_to do |format|
      if @googlecontact.update_attributes(params[:googlecontact])
        format.html { redirect_to(@googlecontact, :notice => 'Googlecontact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @googlecontact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /googlecontacts/1
  # DELETE /googlecontacts/1.xml
  def destroy
    @googlecontact = Googlecontact.find(params[:id])
    @googlecontact.destroy

    respond_to do |format|
      format.html { redirect_to(googlecontacts_url) }
      format.xml  { head :ok }
    end
  end
end
