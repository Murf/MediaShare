class MediafilesController < ApplicationController
  # GET /mediafiles
  # GET /mediafiles.json
  def index
    @mediafiles = Mediafile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mediafiles }
    end
  end

  # GET /mediafiles/1
  # GET /mediafiles/1.json
  def show
    @mediafile = Mediafile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mediafile }
    end
  end

  # GET /mediafiles/new
  # GET /mediafiles/new.json
  def new
    @mediafile = Mediafile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mediafile }
    end
  end

  # GET /mediafiles/1/edit
  def edit
    @mediafile = Mediafile.find(params[:id])
  end

  # POST /mediafiles
  # POST /mediafiles.json
  def create
    @mediafile = Mediafile.new(params[:mediafile])

    respond_to do |format|
      if @mediafile.save
        format.html { redirect_to @mediafile, notice: 'Mediafile was successfully created.' }
        format.json { render json: @mediafile, status: :created, location: @mediafile }
      else
        format.html { render action: "new" }
        format.json { render json: @mediafile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mediafiles/1
  # PUT /mediafiles/1.json
  def update
    @mediafile = Mediafile.find(params[:id])

    respond_to do |format|
      if @mediafile.update_attributes(params[:mediafile])
        format.html { redirect_to @mediafile, notice: 'Mediafile was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @mediafile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mediafiles/1
  # DELETE /mediafiles/1.json
  def destroy
    @mediafile = Mediafile.find(params[:id])
    @mediafile.destroy

    respond_to do |format|
      format.html { redirect_to mediafiles_url }
      format.json { head :ok }
    end
  end
end
