class Pic < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :picture
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }#, :default_url => "/images/:style/missing.png" 
  belongs_to :page
end
