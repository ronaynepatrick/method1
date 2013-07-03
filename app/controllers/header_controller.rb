class HeaderController < ApplicationController
	def search
		redirect_to :home_page
	end

	def create_page
		redirect_to :create_page
	end
end
