class AnalyserController < ApplicationController
  before_filter :authenticate_user!

  def analyse
    mediafiles = Mediafile.all
    mediafiles.each do |mediafile|
      medium = Medium.new
      search = Imdb::Search.new(mediafile.filename)
      if search.movies[0]
        medium.title = search.movies[0].title
        #medium.genre = search.movies[0].genre
        medium.imdb_id = search.movies[0].id
      end
      medium.save
    end
  end
end
