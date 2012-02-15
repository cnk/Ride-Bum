require 'spec_helper'

describe Identity do
  context "Required fields" do
    it "should require email" do
      FactoryGirl.build(:identity, email: nil).should_not be_valid
    end
    
    it "should require name" do
      FactoryGirl.build(:identity, name: nil).should_not be_valid
    end
    
    it "should not take bad email address" do
      i = FactoryGirl.build(:identity, email: "emailtestcomsys")
      i.should_not be_valid
      i.errors[:email].should include('is invalid')
    end
    
    it "should not take bad email address" do
      i = FactoryGirl.build(:identity, email: "email@testcomsys")
      i.should_not be_valid
      i.errors[:email].should include('is invalid')
    end
    
    bad_emails = ["testattest", "testattest.com", "test@testcom"]
    bad_emails.each do |email|
      it "should not take bad email address" do
        i = FactoryGirl.build(:identity, email: email)
        i.should_not be_valid
        i.errors[:email].should include('is invalid')
      end
    end
    
    good_emails = ["test@test.com", "test@test.coms", "test@test.fl"]
    good_emails.each do |email|
      it "should take good email address" do
        i = FactoryGirl.build(:identity, email: email)
        i.should be_valid
        #i.errors[:email].should include('is invalid')
      end
    end
    
    it "should create a valid identity" do
      FactoryGirl.build(:identity).should be_valid
    end
    
    it "should require a unique email address" do
      i = FactoryGirl.create(:identity, email: "email@test.com")
      i.should be_valid
      i = FactoryGirl.build(:identity, email: "email@test.com")
      i.should_not be_valid
    end
  end
end
