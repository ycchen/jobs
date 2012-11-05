class Job < ActiveRecord::Base
  attr_accessible :title, :job_type, :occupation, :company_name, :location, :url, :description, :apply_information, :deadline, :user_id, :deadline_forever

  JOB_TYPE = %w[Full-time Part-time Contract Internship Other]
  OCCUPATION = 	['Web back-end', 'Web front-end', 'Web-design', 'QA/Testing', 'Other']

  validates_presence_of :title
  validates_presence_of :job_type
  validates_presence_of :company_name
  validates_presence_of :occupation
  validates_presence_of :location
  validates_presence_of :description
  validates_presence_of :apply_information

  validates_inclusion_of :job_type, :in => JOB_TYPE
  validates_inclusion_of :occupation, :in => OCCUPATION

  belongs_to  :owner, :class_name => "User", :foreign_key => "user_id"
  
  def deadline_forever
  	@deadline_forever ||= !self.deadline
  end

  def self.search(search)
    if search
      find(:all, :conditions => 
        ['title like ? OR job_type like ? OR occupation like ? OR company_name like ? OR URL like ? OR location like ? OR description like ? OR apply_information like ?',
          "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"
        ])
    else
      find(:all)
    end
      
   end 
end
