class News < ActiveRecord::Base
  attr_accessible :author_id, :content, :title ,:is_show_public ,:item_id
  has_many :comments
  has_many :users ,:through => :comments
  has_one :notify
end
