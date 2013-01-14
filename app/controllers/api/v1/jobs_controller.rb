module Api
	module V1
		class JobsController < ApplicationController

			# adding following class to handle adding additional information 
			# to the json data set, in this case is to add "created_on" additional column
			# and the data is base on created_at column
			class Job < :: Job
				def as_json(options={})
					super.merge(created_on: created_at.to_date )	
				end
			end

			respond_to :json

			def index
				respond_with Job.all
			end

			def show
				respond_with Job.find(params[:id])
			end

			def create
				respond_with Job.create(params[:job])
			end

			def update
				respond_with JobJob.update(params[:id], params[:job])
			end

			def destroy
				respond_with JobJob.destroy(params[:id])
			end
		end
	end
end