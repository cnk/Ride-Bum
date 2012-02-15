require 'spec_helper'

describe User do
  context "Required fields" do
    it "should require name" do
      FactoryGirl.build(:user, name: nil).should_not be_valid
    end

    it "should require provider" do
      FactoryGirl.build(:user, provider: nil).should_not be_valid
    end

    it "should require uid" do
      FactoryGirl.build(:user, uid: nil).should_not be_valid
    end
  end
end
