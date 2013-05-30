class News < ActiveRecord::Base
  attr_accessible :author_id, :content, :title
  has_many :comments
  has_many :users ,:through => :comments
end
