# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

Rake::Task['db:reset'].invoke

user = User.create(:email => "admin@aol.com", :password => "foobar", :password_confirmation => "foobar")
user.confirmed_at = Time.now
user.save

job = Job.create!(	:title => "Rails developer", :url => "http://www.dmsva.com",
					:company_name => "DMSVA", :job_type => "Full-time", :occupation => "Web back-end",
					:location => "Herndon, VA", :user_id => 1,
					:description => "This is awesome Ruby job!<br> The salary is also great!", :apply_information => "Please email to me")

10.times do |n|
	user = User.create(:email=> Faker::Internet.email, :password => "foobar", :password_confirmation => "foobar")
	user.confirmed_at = Time.now
	user.display_name = Faker::Name.first_name
	user.save
end

number = [1,2,3,4,5,6,7,8,9,10]

30.times do |n|
	Job.create!(:title => "Developer Job #{n}", 
				:url => Faker::Internet.url,
				:company_name => Faker::Company.name,
				:job_type => Job::JOB_TYPE.shuffle.first,
				:occupation => Job::OCCUPATION.shuffle.first,
				:location => "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
				:user_id =>  number.shuffle.first,
				:description => Faker::Lorem.sentences,
				:apply_information => "Please email to #{Faker::Internet.email}"
				)
end