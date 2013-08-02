require 'spec_helper'

describe SessionsController do

  describe "new action" do
    it "should call the set_current_user filter" do
      ApplicationController.any_instance.should_receive(:set_current_user)
      get :new
    end
  end

  describe "create action" do
    before :each do
      @moviegoer = FactoryGirl.create(:moviegoer)
    end
    it "should not call the set_current_user filter" do
      Moviegoer.stub(:find_or_create_from_auth_hash).and_return(@moviegoer)
      ApplicationController.should_not_receive(:set_current_user)
      post :create
    end
  end

  describe "destroy action" do
    it "should call the set_current_user filter" do
      ApplicationController.any_instance.should_receive(:set_current_user)
      delete :destroy
    end
    it "redirect to the root path" do
      delete :destroy
      response.should redirect_to root_path
    end
  end

end
