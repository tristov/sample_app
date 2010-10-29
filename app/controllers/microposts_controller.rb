class MicropostsController < ApplicationController
  before_filter :authenticate, :only =>[:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = t(:micropost_created)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      @feed_items = []

      respond_to do |format|
        format.html { render 'pages/home' }
        format.js
      end
    end
  end

  def destroy
    @micropost.destroy
   respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

private
  def authorized_user
    @micropost = Micropost.find(params[:id])
    redirect_to root_path unless current_user?(@micropost.user)
  end

end
