class User < ActiveRecord::Base
  attr_accessible :name, :pwd, :rank

  has_many :comments

  has_many :news ,:through=>:comments
end
