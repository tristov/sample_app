class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
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

  def edit
    # This line is commented because its already called in
    # 'correct_user' private method
    #@user = User.find(params[:id])
    @title = "Edit user"
  end

   def update
    # This line is commented because its already called in
    # 'correct_user' private method
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

 private
  def authenticate
    deny_access unless signed_in?
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
