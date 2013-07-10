class Document < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :doc
  belongs_to :page
  has_attached_file :doc 
  validates_attachment_content_type :doc, content_type: ['application/pdf']
end
