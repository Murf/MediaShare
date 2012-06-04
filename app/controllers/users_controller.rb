class UsersController < ApplicationController

  before_filter :confirm_logged_in
  before_filter :confirm_admin
  
  def index
    list
    render('list')
  end
  
  def list
    @users = User.sorted
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User created.'
      redirect_to(:action => 'list')
    else
      render("new")
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User updated.'
      redirect_to(:action => 'list')
    else
      render("edit")
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User destroyed."
    redirect_to(:action => 'list')
  end

  #media funcionality for users

  #show all discovered mdeiafiles that are not assigned to medium
  def pending
    @mediafiles = Mediafile.all(:conditions => 'media_id IS NULL')
  end

end
