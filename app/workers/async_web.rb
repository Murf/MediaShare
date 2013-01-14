class AsyncWeb
  include Sidekiq::Worker

  def perform(user_id)
    if (User.find(user_id).has_role? "admin")
      mediafiles = Mediafile.all
    else
      mediafiles = Mediafile.where(:user_id => user_id)
    end

    mediafiles.each do |mediafile|
      if (!mediafile.medium)
        search = Imdb::Search.new(File.basename(mediafile.filename, '.*').downcase.tr("_", " "))
        search.movies.each do |movie|
          if movie.type == "Movie"
            imdbId= movie.id
            medium = Medium.find_by_imdb_id(imdbId)
            if (!medium)
              medium = Medium.new
              medium.title = movie.title
              #medium.genre = search.movies[0].genre   #genre not availble in this query need to find it elsewhere
              medium.imdb_id = imdbId
              medium.save
            end
            mediafile.medium = medium
            mediafile.save
            break
          end
        end
        sleep 1
      end
    end
  end

  def rescue_action(exception)
    puts(exception)    
    #if ::ActionController::MissingTemplate === exception
    #   render :text => 'rescued'
    #else
    #   super
    #end
  end
end
