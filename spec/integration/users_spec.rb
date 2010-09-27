require 'spec_helper'

describe "Users" do
  describe "signup" do

    describe "failure" do

      it "should not make a new user" do
        visit signup_path
        click_button
        response.should render_template('users/new')
        response.should have_tag("div#errorExplanation")
      end#.should_not change(User, :count)
    end

    describe "success" do

      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Tode Ristov"
          fill_in "Email",        :with => "tode@toderistov.com"
          fill_in "Password",     :with => "Negotino"
          fill_in "Confirmation", :with => "Negotino"
          click_button
          response.should render_template('users/show')
        end#.should change(User, :count).by(1)
      end
    end
  end
end
