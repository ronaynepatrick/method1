class ImageController < ApplicationController
	def show
		@picture = Pic.find(params[:id])
	end
end
