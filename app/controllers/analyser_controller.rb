class AnalyserController < ApplicationController
  before_filter :authenticate_user!

  def analyse
    authorize! :index, Mediafile, :message => 'Not authorized to index'
    AsyncWeb.perform_async(current_user.id)
    redirect_to media_url, notice: 'File analysis job submitted.'
  end
end
