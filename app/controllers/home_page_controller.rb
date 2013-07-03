class HomePageController < ApplicationController
	before_filter :require_user,  :only => :load

	def load
		
	end
end
