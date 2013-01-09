class AnalyserController < ApplicationController
  before_filter :authenticate_user!

  def analyse
    mediafiles = Mediafile.all
    mediafiles.each do |mediafile|
      if (!mediafile.medium)
        search = Imdb::Search.new(File.basename(mediafile.filename, '.*'))
        if search.movies[0]
          imdbId= search.movies[0].id
          medium = Medium.find_by_imdb_id(imdbId)
          if (!medium)
            medium = Medium.new
            medium.title = search.movies[0].title
            #medium.genre = search.movies[0].genre
            medium.imdb_id = imdbId
            medium.save
          end
          mediafile.medium = medium
          mediafile.save
        end
      end
    end
    redirect_to media_url, notice: 'File analysis complete.'
  end
end
