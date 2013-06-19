class Notify < ActiveRecord::Base
  belongs_to :news
  belongs_to :user
  attr_accessible :content, :is_read, :target_id
end
