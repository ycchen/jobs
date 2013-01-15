module Api
	module V2
		class JobsController < ApplicationController
			#http_basic_authenticate_with :name => "admin", :password => "admin"
			before_filter :restrict_access
			# adding following class to handle adding additional information 
			# to the json data set, in this case is to add "created_on" additional column
			# and the data is base on created_at column
			# class Job < :: Job
			# 	def as_json(options={})
			# 		super.merge(created_on: created_at.to_date )	
			# 	end
			# end

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

		private

			# def restrict_access
			# 	api_key = ApiKey.find_by_access_token(params[:access_token])
			# 	head :unauthorized unless api_key
			# end

			# using authenticate_or_request_with_http_token method
			def restrict_access

				if params[:access_token]
					api_key = ApiKey.find_by_access_token(params[:access_token])
					head :unauthorized unless api_key
				else
					authenticate_or_request_with_http_token do |token, options|
						ApiKey.exists?(access_token: token)
					end
				end
			end

		end
	end
end