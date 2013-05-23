class Job < ActiveRecord::Base
  attr_accessible :title, :job_type, :occupation, :company_name, :location, :url, :description, :apply_information, :deadline, :user_id, :deadline_forever, :status

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
  
  before_validation :set_status, :on => :create

  # scope :online, where("deadline is NULL OR deadline > ?", Date.today)
  scope :published, lambda{ where(:status => "published")}
  # scope :open, lambda { where("deadline is NULL OR deadline > ?", Date.today) }
  # scope :closed, lambda {where(:status => "closed")}

  include Tire::Model::Search
  include Tire::Model::Callbacks

  # ElasticSerach
  # def self.search(params)
  #   tire.search(load: true)    do
  #     query { string params[:search]} if params[:search].present?
  #   end
  # end

  # searchable do
  #   text :title, :job_type, :occupation, :company_name, :location, :url, :description
  # end

  def deadline_forever
  	@deadline_forever ||= !self.deadline
  end



  # def self.search(search)
  #   if search
  #     find(:all, :conditions => 
  #       ['title like ? OR job_type like ? OR occupation like ? OR company_name like ? OR URL like ? OR location like ? OR description like ? OR apply_information like ?',
  #         "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"
  #       ])
  #   else
  #     find(:all)
  #   end
  #  end

   def open
    self.status = "published"  
   end

   def close
     self.status = "closed"
   end

   def closed?
     self.status == "closed"
   end

   private

   def set_status
      self.status = "published"
    end 
end
