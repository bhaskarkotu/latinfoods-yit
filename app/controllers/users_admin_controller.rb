class UsersAdminController < ApplicationController
	before_filter :authenticate_user!

	def index
		@users = User.paginate(:per_page => 10, :page => params[:page]).order('created_at DESC')
	end

	def show
    @user = User.find(params[:id])
  end

	def new
		@user = User.new
	end

	def edit
    @user = User.find(params[:id])
  end

	def create
		@user = User.new
		@user.first_name = params[:user][:first_name]
		@user.last_name = params[:user][:last_name]
		@user.email = params[:user][:email]
		@user.institution = params[:user][:institution]
		@user.password = params[:user][:password]
		@user.password_confirmation = params[:user][:password_confirmation]
		respond_to do |format|
			if @user.save
		    @user.add_role params[:user][:role]
		    format.html { redirect_to users_admin_index_path }
		    flash[:notice] =  'User successfully created.' 
			else
	    	format.html {render action: 'new'}
			end
		end
	end

  def update
    @user = User.find(params[:id])
    @user.first_name = params[:user][:first_name] if (params[:user][:first_name].length != 0)
    @user.last_name = params[:user][:last_name] if (params[:user][:last_name].length != 0)
		@user.institution = params[:user][:institution] if (params[:user][:institution].length != 0)
		@user.email = params[:user][:email] if (params[:user][:email].length != 0)
		@user.password = params[:user][:password] if !params[:user][:password].length !=0
		@user.password_confirmation = params[:user][:password_confirmation] if !params[:user][:password_confirmation].length != 0
		respond_to do |format|
		  if @user.save
	    	@user.roles.clear
	    	@user.add_role params[:user][:role]
		    format.html { redirect_to users_admin_path } 
		    flash[:notice] =  'User was successfully updated.' 
		  else
		    format.html {render action: 'edit'}
		  end
	  end
	end

	def destroy
	  @user = User.find(params[:id])
	  @user.roles.clear
	  @user.destroy
	  @users = User.paginate(:per_page => 10, :page => params[:page]).order('created_at DESC')

	  respond_to do |format|
	    format.js
	    format.html { redirect_to users_admin_index_path }
	    format.json { head :no_content }
	  end
	end
end

