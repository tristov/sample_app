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
      #Exercise 8.6.3 start
      @user.password = nil
      @user.password_confirmation = nil
      #Exercise 8.6.3 end
      render :new
    end
  end

  def new
    @title = "Sign up"
    @user = User.new
  end
end
