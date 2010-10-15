require 'spec_helper'

describe MicropostsController do

  integrate_views

  describe "acess control" do
    it "should deny acess to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end
    it "should deny access to 'destroy" do
      delete :destroy
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'"do
    before(:each)do
      @user = test_sign_in(Factory(:user))
      @attr = {:content => "Lorem ipsum" }
      @micropost = Factory(:micropost, @attr.merge(:user => @user))
      @user.microposts.stub!(:build).and_return(@micropost)
    end

    describe "failure"do
      before(:each)do
        @micropost.should_receive(:save).and_return(false)
      end

      it "should render the home page" do
        post :create, :micropost => @attr
        response.should render_template('pages/home')
      end

    end

    describe "success" do
      before(:each)do
        @micropost.should_receive(:save).and_return(true)
        post :create, :micropost => @attr
      end

      it "should redirect to the home page"do
        response.should redirect_to(root_path)
      end
      
      it "should have a flash message"do
        flash[:success].should =~ /Micropost created!/i
      end
    end
  end
  
  #Delete these examples and add some real ones
  it "should use MicropostsController" do
    controller.should be_an_instance_of(MicropostsController)
  end
  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @micropost = Factory(:micropost, :user => @user)
      end

      it "should deny access" do
        @micropost.should_not_receive(:destroy)
        delete :destroy, :id => @micropost
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @micropost = Factory(:micropost, :user => @user)
        Micropost.should_receive(:find).with(@micropost).and_return(@micropost)
      end

      it "should destroy the micropost" do
        @micropost.should_receive(:destroy).and_return(@micropost)
        delete :destroy, :id => @micropost
      end
    end
  end
end
