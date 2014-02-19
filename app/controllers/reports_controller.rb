class ReportsController < ApplicationController
	def index
		@users = User.paginate(:per_page => 10, :page => params[:page]).order('created_at DESC')	
	end

	def generatereport
	 	respond_to do |format|
      format.pdf do
       render :pdf => "file_name",
             :template => 'reports/generatereport.html.erb',
             :orientation => 'Landscape'               
      end
    end    
	end
end
  