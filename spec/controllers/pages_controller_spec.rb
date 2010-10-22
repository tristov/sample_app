require 'spec_helper'

describe PagesController do
  integrate_views

  before(:each) do
    @base_title = 'Sample App'
  end
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_tag("title",@base_title+" | Home")
    end

  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_tag("title",@base_title+" | Contact")
    end
  end
  
  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_tag("title",@base_title+" | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should have the right title" do
      get 'help'
      response.should have_tag("title",@base_title+" | Help")
    end
  end

  describe "GET 'home'"do

    before(:each)do
      @user = test_sign_in(Factory(:user))
    end

#    it"should paginate the micropost"do
#      30.times{Factory(:micropost, :user =>@user)}
#      get :home
#      response.should have_tag('div.pagination')
#      response.should have_tag('span', /previous/i)
#
#      response.should have_tag("span.current", "1")
#      response.should have_tag("a[href=?]", "/pages/home?locale=en&page=2", '2')
#      response.should have_tag("a[href=?]", "/pages/home?locale=en&page=2", 'Next &raquo;')
#
#    end
    
    it"should not show Delete link if micropost not from current user"do
      @attr = {:name => "Martina Ristova",
        :email => "martina.nikolovska@hotmail.com",
        :password => "Negotino1",
        :password_confirmation => "Negotino1"
      }
      @another_one = Factory(:user, @attr)

      20.times{Factory(:micropost, :user => @another_one)}
      get :home
      response.should_not have_tag('span', /Delete/i)
      
    end

    it"should show Delete link if micropost from current user"do
      20.times{Factory(:micropost, :user => @user)}
      get :home
      response.should have_tag('span', /Delete/i)
    end

  end
end
