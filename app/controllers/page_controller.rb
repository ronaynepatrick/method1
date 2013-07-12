class PageController < ApplicationController
	def show
		@page = Page.find(params[:id])
		passages = Passage.where(page_id: params[:id])
		videos = Video.where(page_id: params[:id])
		docs = Document.where(page_id: params[:id])
		pics = Pic.where(page_id: params[:id])
		@content = passages+videos+docs+pics
	end
end
