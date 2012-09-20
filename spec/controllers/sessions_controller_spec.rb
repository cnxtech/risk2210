require 'spec_helper'

describe SessionsController do
  
  let(:player) { FactoryGirl.create(:player, password: "secret1", password_confirmation: "secret1") }
  
  describe "destroy" do
    it "should log the user out" do
      login player

      delete :destroy

      session[:player_id].nil?.should == true
      response.should redirect_to root_path
      flash[:notice].should_not be_nil
    end
  end

  describe "new" do
    it "should have a session object" do
      get :new

      assigns(:session).should_not be_nil
      assigns(:page_title).should_not be_nil
    end
  end

  describe "create" do
    it "should login the user if valid credentials are submitted" do
      post :create, session: {email: player.email, password: "secret1", remember_me: "0"}

      response.should redirect_to new_game_path
      flash.now[:notice].should_not be_nil
    end
    it "should reload the new page if invalid credentials are submitted" do
      post :create, session: {email: player.email, password: "", remember_me: "0"}

      assigns(:session).should_not be_nil
      assigns(:page_title).should_not be_nil
      flash.now[:alert].should_not be_nil
      response.should render_template :new
    end
    it "should set the remember me cookie" do
      post :create, session: {email: player.email, password: "secret1", remember_me: "1"}

      cookies.signed[:remeber_me_token].should == player.remember_me_token
    end
  end

  describe "authenticate_facebook" do
    it "should authenticate a user via Facebook Connect" do
      pending
    end
  end

  describe "failure" do
    it "should redirect the user to the root path with the error message from Facebook Connect" do
      get :failure, message: "Something went wrong!"

      response.should redirect_to root_path
      flash[:alert].should == "Facebook authentication error: Something went wrong!"
    end
  end

end
