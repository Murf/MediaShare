class AccessController < ApplicationController

  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout, :jsonlogin, :jsonlogout]

  def index
    menu
    render('menu')
  end

  def menu
  end

  def login
      # login form
  end

  def jsonlogin
    authorized_user = User.authenticate(params[:username], params[:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      session[:level] = authorized_user.level
      render json: {:result => "ok"}
    else
      render json: {:result => "error"}
    end
  end

  def attempt_login
    authorized_user = User.authenticate(params[:username], params[:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      session[:level] = authorized_user.level
      flash[:notice] = "You are now logged in."
      redirect_to(:action => 'menu')
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end

  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "You have been logged out."
    redirect_to(:action => "login")
  end

  def jsonlogout
    session[:user_id] = nil
    session[:username] = nil
    render json: {:result => "ok"}
  end

end
