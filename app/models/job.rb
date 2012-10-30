class Job < ActiveRecord::Base
  attr_accessible :title, :job_type, :occupation, :company_name, :location, :url, :description, :apply_information, :deadline, :user_id, :deadline_forever


  JOB_TYPE = %w[Full-time Part-time Contract Internship Other]
  OCCUPATION = 	['Web back-end', 'Web front-end', 'Web-design', 'QA/Testing', 'Other']

  def deadline_forever
  	@deadline_forever ||= !self.deadline
  end

end
