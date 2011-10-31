require 'spec_helper'

describe User do
  before (:each) do
    @attr = { :name => "Example User", :email =>"user@example.com"}
  end
	
  it "should create a new instance given valid attributes" do
    User.create!(@attr)  
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => "" ) )
	no_name_user.should_not be_valid
  end 
  
  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => "" ) )
	no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    too_long_user = User.new (@attr.merge(:name => ("s" * 51)))
	too_long_user.should_not be_valid
  end 
  
  it "should reject invalid email addresses" do
    addresses = %w[gedesh@g,com user_ged.com gedanna.]
	addresses.each do |address|
	  invalid_email_user = User.new(@attr.merge(:email => address))
	  invalid_email_user.should_not be_valid
	  end
    end

  it "should reject users with duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
    end	
end  
