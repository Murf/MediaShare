class MediafilesController < ApplicationController

  before_filter :authenticate_user!

  # GET /mediafiles
  def index
    @mediafiles = Mediafile.all
  end

   # GET /mediafiles/index.json
  def jsonindex
    #@mediafiles = Mediafile.all
    @mediafiles = Mediafile.first
    render json: @mediafiles
  end

  # GET /mediafiles/1
  # GET /mediafiles/1.json
  def show
    @mediafile = Mediafile.find(params[:id])
    name= File.basename(@mediafile.filename, '.*')
    if (params[:query])
      if  (params[:query][:name])
        name = params[:query][:name]
      end
    end
    search = Imdb::Search.new(name)
    if (search.movies.count > 0)
      @movies = search.movies
    end
    #render json: {"result" => params[:query][:name]}
    respond_to do |format|
      format.html # delete.html.erb
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
    @search = Imdb::Search.new(@mediafile.filename)
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

  # PUT /mediafiles/insert.json

  def insert
    @mediafile = Mediafile.new(:filename => params[:filename], :relativepath => params[:relativepath], :remote_id => params[:remoteid], :user_id => current_user.id)
    if @mediafile.save
      render json: {:result => "ok"}
    else
      render json: {:result => "error"}
    end
  end


  # PUT /mediafiles/1
  # PUT /mediafiles/1.json
  def update
    @mediafile = Mediafile.find(params[:id])
    imdb =Imdb::Movie.new(params[:mediafile][:medium])
    medium =Medium.new(:imdb_id=>params[:mediafile][:medium],:title=>imdb.title)
    medium.save
    @mediafile.media_id=medium.id
        respond_to do |format|
      if @mediafile.save
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

  #assign a new medium to mediafile
  def select
    mediafile = Mediafile.find(params[:id])
    imdbId= params[:imdb_id]
    title= params[:title]
    #genre= params[:genre]
    medium = Medium.find_by_imdb_id(imdbId)
    if (!medium)
      medium = Medium.new
      medium.title = title
      #medium.genre = genre
      medium.imdb_id = imdbId
      medium.save
    end
    mediafile.medium = medium
    mediafile.save
    redirect_to mediafile, notice: 'New Media selected for this Media File.'
  end


  #show all discovered mediafiles that are not assigned to medium
  def pending
    @mediafiles = Mediafile.all(:conditions => 'media_id IS NULL')
  end

end
