class PagesController < ApplicationController
  def home
    @title = t(:home)
    if signed_in?
      @micropost = Micropost.new
      @feed_items = Micropost.all.paginate(:page => params[:page] || 1, :per_page => 5)
    end
    @micropost = Micropost.new if signed_in?
  end

  def contact
    @title = t(:contact)
  end

  def about
    @title = t(:about)
  end

  def help
    @title = t(:help)
  end

end
