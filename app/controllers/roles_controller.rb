class RolesController < ApplicationController
	before_filter :authenticate_user!

	def index
		@roles = Role.paginate(:per_page => 10, :page => params[:page]).order('created_at DESC')
	end

	def show
    @role = Role.find(params[:id])
  end

	def new
		@role = Role.new
		@url = {controller: 'roles', action: 'create', method: :post}
	end

	def edit
    @role = Role.find(params[:id])
    @url = {controller: 'roles', action: 'update', method: :put}
  end

	def create
		
		@role = Role.new(params[:role])
		temp = false
		Role.all.each do |rolename|
			if rolename.name == params[:role][:name]
				temp = true
				break
			end
		end
		respond_to do |format|
	  	if (temp == false)  &&  @role.save
	    	format.html { redirect_to roles_path }
	    	flash[:notice] = 'Role successfully created.'
	  	else
	    	format.html { render action: "new" }
	    	flash[:notice] = 'Role already exist'
	  	end
		end
	end


  def update
  	temp = false
		Role.all.each do |rolename|
			if rolename.name == params[:role][:name]
				temp = true
				break
			end
		end
    @role = Role.find(params[:id])
		respond_to do |format|
		  if (temp == false) && @role.update_attributes(params[:role])
		    format.html { redirect_to roles_path }
		    flash[:notice] = 'Role successfully updated.' 
		  else
		    format.html { render action: "edit" }
		    flash[:notice] = 'Role already exist'
		  end
    end
  end

	def destroy
		temp = true
	  @role = Role.find(params[:id])
	  User.all.each do |user|
	  	if user.roles.first.id == @role.id
	  		temp = false
	  		break
	  	end
	  end 
		respond_to do |format|
		  if temp 
		  	flash[:notice] = "Can't delete role Which is already assigned."
		  	@roles = Role.paginate(:per_page => 10, :page => params[:page]).order('created_at DESC')
		    format.html { redirect_to roles_path }
		  else
		  	@role.destroy
		  	@roles = Role.paginate(:per_page => 10, :page => params[:page]).order('created_at DESC')
		  	flash[:notice] = 'Role successfully deleted.' 
		    format.html { redirect_to roles_path }
		  end
	  end
	end
end
