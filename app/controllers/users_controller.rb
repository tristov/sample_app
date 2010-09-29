class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_path(@user)
    else
      @title = "Sign up"
      render :new
    end
  end

  def new
    @title = "Sign up"
    @user = User.new
  end
end
