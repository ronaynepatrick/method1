class User < ActiveRecord::Base
  attr_accessible :title, :body, :email, :name, :password, :password_confirmation, :login 

  has_many :pages
  
  acts_as_authentic do |c|
  	c.login_field = 'email'
  end
end
