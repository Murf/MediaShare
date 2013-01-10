class MediaController < ApplicationController

  before_filter :authenticate_user!

  # GET /media
  # GET /media.json
  def index
    authorize! :index, Medium, :message => 'Not authorized to index'
    @media = Medium.includes(:mediafiles).where("mediafiles.id IS NOT NULL and mediafiles.user_id ="+current_user.id.to_s)
    if (Mediafile.includes(:medium).where('medium_id IS NULL').count > 0)
      @unlinked_mediafiles = true
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media }
    end
  end

  # GET /media/1
  # GET /media/1.json
  def show
    authorize! :show, Medium, :message => 'Not authorized to show'
    @medium = Medium.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @medium }
    end
  end

  # GET /media/new
  # GET /media/new.json
  def new
    authorize! :new, Medium, :message => 'Not authorized to new'
    @medium = Medium.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medium }
    end
  end

  # GET /media/1/edit
  def edit
    authorize! :edit, Medium, :message => 'Not authorized to edit'
    @medium = Medium.find(params[:id])
  end

  # POST /media
  # POST /media.json
  def create
    authorize! :create, Medium, :message => 'Not authorized to create'
    @medium = Medium.new(params[:medium])

    respond_to do |format|
      if @medium.save
        format.html { redirect_to @medium, notice: 'Medium was successfully created.' }
        format.json { render json: @medium, status: :created, location: @medium }
      else
        format.html { render action: "new" }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /media/1
  # PUT /media/1.json
  def update
    authorize! :update, Medium, :message => 'Not authorized to update'
    @medium = Medium.find(params[:id])

    respond_to do |format|
      if @medium.update_attributes(params[:medium])
        format.html { redirect_to @medium, notice: 'Medium was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1
  # DELETE /media/1.json
  def destroy
    authorize! :destroy, Medium, :message => 'Not authorized to destroy'
    @medium = Medium.find(params[:id])
    @medium.mediafiles.each do |mediafile|
      mediafile.medium=nil
      mediafile.save
    end
    @medium.destroy

    respond_to do |format|
      format.html { redirect_to media_url }
      format.json { head :ok }
    end
  end
end
