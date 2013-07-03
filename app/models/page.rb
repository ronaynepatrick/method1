class Page < ActiveRecord::Base
  attr_accessible :title, :user_id
  belongs_to :user
  has_many :passages
  has_many :documents
  has_many :videos
  has_many :pictures
end
