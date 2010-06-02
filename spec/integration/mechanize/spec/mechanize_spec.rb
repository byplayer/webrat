require File.dirname(__FILE__) + "/spec_helper"

describe "Webrat's Mechanize mode" do
  TEST_HOST = "localhost:9292"

  it "should work" do
    response = visit("http://#{TEST_HOST}/")
    response.should contain("Hello World")
  end

  it "should follow redirects" do
    response = visit("http://#{TEST_HOST}/internal_redirect")
    response.should contain("Redirected")
    response.uri.to_s.should == "http://#{TEST_HOST}/redirected"
  end

  it "should submit forms" do
    visit "http://#{TEST_HOST}/form"
    fill_in "Email", :with => "albert@example.com"
    response = click_button "Add"

    response.should contain("Welcome albert@example.com")
  end

  it "should not follow external redirects" do
    response = visit("http://#{TEST_HOST}/external_redirect")
    response.uri.to_s.should == "http://#{TEST_HOST}/external_redirect"
    response.header['location'].should == "http://example.test/"
  end
end
