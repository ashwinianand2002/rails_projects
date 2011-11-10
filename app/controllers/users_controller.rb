class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit,:update]
  before_filter :correct_user, :only => [:edit,:update]

	def new
    @user = User.new
		@title = "Sign up"
  end
  
  def show
    @user = User.find(params[:id])
		@title = @user.name
  end
	
	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			@title = "Sign up"
			render 'new'
		end
  end

  def edit
    @user= User.find(params[:id])
    @title="Edit User"
  end

  def update
    @user= User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success]= "Profile updated"
      redirect_to @user
    else
      @title="Edit User"
      render 'edit'
    end
  end

  def index
    @title = "All users"
    @users = User.all
  end

  private

  def authenticate
    deny_access "Please sign in" unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    deny_access "You are not the correct user for this operation" unless current_user == @user
  end


end
