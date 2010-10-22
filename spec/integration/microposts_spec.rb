require 'spec_helper'

describe "Microposts" do

  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email,    :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end

  describe "creation" do

    describe "failure" do

      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in :micropost_content, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_tag("div#errorExplanation")
        end.should_not change(Micropost, :count)
      end
    end

    describe "success" do

      it "should make a new micropost" do
        content = "Lorem ipsum dolor sit amet"
        lambda do
          visit root_path
          fill_in :micropost_content, :with => content
          click_button
          response.should have_tag("span.content", content)
        end.should change(Micropost, :count).by(1)
      end
    end
  end

  describe "destruction" do

    it "should destroy a micropost" do
      # Create a micropost.
      visit root_path
      fill_in :micropost_content, :with => "lorem ipsum"
      click_button
      # Destroy it.
      lambda { click_link "delete" }.should change(Micropost, :count).by(-1)
    end
  end

  describe "sidebar" do
    before(:each)do
      visit root_path
    end

    it"shoud contain the sidebar" do
      response.should have_tag("img.gravatar")
      response.should have_tag("span.user_name")
      response.should have_tag("span.microposts")
    end

    it "should contain proper pluralization for one post"do
      create_post(Faker::Lorem)
      response.should have_tag("span.microposts", /1 post/i)
    end

    it "should contain proper pluralization for one post"do
      create_post(Faker::Lorem)
      create_post(Faker::Lorem)
      response.should have_tag("span.microposts", /2 posts/i)
    end

  end

  

  # method for creating microposts
  def create_post(string)
    fill_in :micropost_content, :with => string
    click_button
  end
  
end
