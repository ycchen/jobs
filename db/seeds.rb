# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(:email => "admin@aol.com", :password => "foobar", :password_confirmation => "foobar")
user.confirmed_at = Time.now
user.save

job = Job.create!(	:title => "Rails developer", :url => "http://www.dmsva.com",
					:company_name => "DMSVA", :job_type => "Full-time", :occupation => "Web back-end",
					:location => "Herndon, VA", :user_id => 1,
					:description => "This is awesome Ruby job!<br> The salary is also great!", :apply_information => "Please email to me")