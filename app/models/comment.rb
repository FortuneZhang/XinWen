class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :news
  attr_accessible  :content, :is_show_public
end
