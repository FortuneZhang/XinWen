class NotifiesController < ApplicationController
  # GET /notifies
  # GET /notifies.json
  def index
    @notifies = Notify.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notifies }
    end
  end

  # GET /notifies/1
  # GET /notifies/1.json
  def show
    @notify = Notify.find(params[:id])

    @notify.is_read = true ;
    @notify.save


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notify }
    end
  end

  # GET /notifies/new
  # GET /notifies/new.json
  def new
    @notify = Notify.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notify }
    end
  end

  # GET /notifies/1/edit
  def edit
    @notify = Notify.find(params[:id])
  end

  # POST /notifies
  # POST /notifies.json
  def create
    @notify = Notify.new(params[:notify])

    respond_to do |format|
      if @notify.save
        format.html { redirect_to @notify, notice: 'Notify was successfully created.' }
        format.json { render json: @notify, status: :created, location: @notify }
      else
        format.html { render action: "new" }
        format.json { render json: @notify.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notifies/1
  # PUT /notifies/1.json
  def update
    @notify = Notify.find(params[:id])

    respond_to do |format|
      if @notify.update_attributes(params[:notify])
        format.html { redirect_to @notify, notice: 'Notify was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notify.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifies/1
  # DELETE /notifies/1.json
  def destroy
    @notify = Notify.find(params[:id])
    @notify.destroy

    respond_to do |format|
      format.html { redirect_to notifies_url }
      format.json { head :no_content }
    end
  end


  def test
    @notify = Notify.last

  end




end
