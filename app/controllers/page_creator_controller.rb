class PageCreatorController < ApplicationController
	before_filter :require_admin, :only => [:new]

	def new
		@page = Page.new	
	end

	def save_new
		@page = Page.new(params[:page])
		@page.save
		session[:page_id] = @page.id
		redirect_to :edit_page
	end

	def new_passage
		passage = Passage.new
		passage.save
		session[:passage] = passage.id
		redirect_to :edit_passage
	end	

	def edit_passage
		@p_id = session[:passage]
		@passage
	end

	def save_passage
		# @passage = Passage.new(params[:passage])
		passage.passage = params[:passage]
		passage.save
		session[:passage] = nil
		redirect_to :edit_page
	end

	def edit_page
		@page = Page.find(session[:page_id])
		passages = Passage.where(page_id: session[:page_id])
		videos = Video.where(page_id: session[:page_id])
		docs = Document.where(page_id: session[:page_id])
		pics = Pic.where(page_id: session[:page_id])
		@content = passages+videos+docs #+pics
	end
end
