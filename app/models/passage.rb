class Passage < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :page
end
