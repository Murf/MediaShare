class AnalyserController < ApplicationController
  before_filter :authenticate_user!

  def analyse
    mediafiles = Mediafile.all
    mediafiles.each do |mediafile|
      if (!mediafile.medium)
        medium = Medium.new
        search = Imdb::Search.new(File.basename(mediafile.filename, '.*'))
        if search.movies[0]
          medium.title = search.movies[0].title
          #medium.genre = search.movies[0].genre
          medium.imdb_id = search.movies[0].id
          medium.save
          mediafile.medium = medium
          mediafile.save
        end
      end
    end
    redirect_to media_url, notice: 'File analysis complete.'
  end
end
