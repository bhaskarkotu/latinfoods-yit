require 'spec_helper'

describe ProfileinfoController do

  describe "GET 'personalinfo'" do
    it "returns http success" do
      get 'personalinfo'
      response.should be_success
    end
  end

  describe "GET 'uploaddatabyexcel'" do
    it "returns http success" do
      get 'uploaddatabyexcel'
      response.should be_success
    end
  end

  describe "GET 'manualdata'" do
    it "returns http success" do
      get 'manualdata'
      response.should be_success
    end
  end

  describe "GET 'search'" do
    it "returns http success" do
      get 'search'
      response.should be_success
    end
  end

  describe "GET 'elearning'" do
    it "returns http success" do
      get 'elearning'
      response.should be_success
    end
  end

  describe "GET 'newsletter'" do
    it "returns http success" do
      get 'newsletter'
      response.should be_success
    end
  end

end
