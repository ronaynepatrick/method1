class HeaderController < ApplicationController
	def search
		stype = params[:stype]
		# @pages = Page.find(19)
		case stype
		when "0"
			if params[:search_q] == ""
				@pages = Page.all
			else
				
			end

		when "1"

		when "2"

		when "3"

		when "4"

		else
			@pages = Page.find(20)
		end
	end

	def create_page
		redirect_to :create_page
	end
end
