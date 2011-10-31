require 'spec_helper'

describe User do
  before (:each) do
    @attr = { 
		:name => "Example User", 
		:email =>"user@example.com",
		:password => "foobar",
		:password_confirmation => "foobar"
	}
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
	
	it "should require a password" do
	  User.new(@attr.merge(:password => "",:password_confirmation => "invalid")).should_not be_valid
	end
		
	it "should require a matching password confirmation" do
	  User.new(@attr.merge(:password_confirmation => "gedesh")).should_not be_valid
	end
	
	it "should reject short passwords" do
		User.new(@attr.merge(:password => "ds" , :password_confirmation => "ds")).should_not be_valid
	end

	it "should reject long passwords" do
		long = "a" * 41
		hash = @attr.merge(:password => long, :password_confirmation => long)
		User.new(hash).should_not be_valid
	end
	
	 describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
	  
	
end
 
