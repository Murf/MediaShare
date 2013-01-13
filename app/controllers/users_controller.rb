class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, User, :message => 'Not authorized to index'
    @users = User.accessible_by(current_ability)
  end

  def show
    authorize! :index, User, :message => 'Not authorized to show'
    @user = User.find(params[:id])
  end

  def update
    authorize! :update, User, :message => 'Not authorized to update'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized to destroy'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

end
