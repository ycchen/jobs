class Post < ActiveRecord::Base
  attr_accessible :title, :user_id, :comment, :type, :content
end
