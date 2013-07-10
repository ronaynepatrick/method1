class Video < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :page
  has_attached_file :vid
end
