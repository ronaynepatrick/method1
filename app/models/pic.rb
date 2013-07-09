class Pic < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :photo
  has_attached_file :photo, :styles => {:large => "600x600>", :medium => "400x400>", :thumb => "100x100>" }#, :default_url => "/images/:style/missing.png" 
  belongs_to :page
end
