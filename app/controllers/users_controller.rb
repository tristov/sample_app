class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => [:destroy]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page] || 1, :per_page => 5)
    @title = CGI.escapeHTML(@user.name)
  end

  def index
    @title = t(:all_users)
    @users = User.paginate(:page => params[:page] || 1, :per_page => 5)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = t(:flash_welcome)
      redirect_to user_path(@user)
    else
      @title = t(:sign_up)
      #Exercise 8.6.3 start
      @user.password = nil
      @user.password_confirmation = nil
      #Exercise 8.6.3 end
      render :new
    end
  end

  def new
    @title = t(:sign_up)
    @user = User.new
  end

  def edit
    # This line is commented because its already called in
    # 'correct_user' private method
    #@user = User.find(params[:id])
    @title = t(:edit_user)
  end

   def update
    # This line is commented because its already called in
    # 'correct_user' private method
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = t(:flash_profile_upd)
      redirect_to @user
    else
      @title = t(:edit_user)
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t(:user_Destroyed)
    redirect_to users_path
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

 private
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
