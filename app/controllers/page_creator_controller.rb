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
		passage.page_id=session[:page_id]
		passage.position=params[:order]
		passage.save
		session[:p_id] = passage.id
		redirect_to :edit_passage
	end	

	def edit_passage
		@passage_id = session[:p_id]
		@pass_edit = Passage.find(session[:p_id])
		if @pass_edit.passage == nil
			@pass_edit.passage = "Enter text here"
			@pass_edit.save
		end
	end

	def save_passage
		pass_edit = Passage.find(session[:p_id])
		pass_edit.passage = params[:passage][:text]
		pass_edit.save
		session[:p_id] = nil
		redirect_to :edit_page
	end

	def move_up
		
	end

	def move_down

	end

	def edit_page
		@page = Page.find(session[:page_id])
		passages = Passage.where(page_id: session[:page_id])
		videos = Video.where(page_id: session[:page_id])
		docs = Document.where(page_id: session[:page_id])
		pics = Pic.where(page_id: session[:page_id])
		@content = passages+videos+docs+pics
	end
end