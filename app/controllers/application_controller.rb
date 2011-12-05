class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'access', :action => 'login')
      return false # halts the before_filter
    else
      return true
    end
  end

    def confirm_admin
    unless session[:level] > 8
      flash[:notice] = "No Access."
      redirect_to(:controller => 'access', :action => 'menu')
      return false # halts the before_filter
    else
      return true
    end
    end

  def confirm_json_logged_in
    unless session[:user_id]
      render json: {:result => "error"}
      return false
    else
      return true
    end
  end


end
