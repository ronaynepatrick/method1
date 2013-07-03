class UserSession < Authlogic::Session::Base
  # attr_accessible :title, :body
  #attr_accessible :title, :body, :email, :name, :password, :password_confirmation, :login 
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
end
