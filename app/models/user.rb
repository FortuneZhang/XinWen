class User < ActiveRecord::Base
  attr_accessible :name, :pwd, :rank, :item_id

  has_many :comments

  has_one :notify

  has_many :news ,:through=>:comments
end
