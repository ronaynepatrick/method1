class PageCreatorController < ApplicationController
	before_filter :require_admin
	# before_filter :load_content

	def new
		@page = Page.new	
	end

	def save_new
		@page = Page.new(params[:page])
		@page.save
		session[:page_id] = @page.id
		redirect_to :edit_page

	end

	def edit_page
		@page = Page.find(session[:page_id])
		passages = Passage.where(page_id: session[:page_id])
		videos = Video.where(page_id: session[:page_id])
		docs = Document.where(page_id: session[:page_id])
		pics = Pic.where(page_id: session[:page_id])
		@content = passages+videos+docs+pics
		session[:content] = @content
	end

#Passage editing functions
	def new_passage
		passage = Passage.new
		passage.page_id=session[:page_id]
		passage.position=params[:current_position]
		passage.linebreak = 0
		passage.save

		session[:p_id] = passage.id
		session[:current_position] = params[:current_position]
		session[:move_to] = params[:move_to]

		passages = Passage.where(page_id: session[:page_id])
		videos = Video.where(page_id: session[:page_id])
		docs = Document.where(page_id: session[:page_id])
		pics = Pic.where(page_id: session[:page_id])
		content = passages+videos+docs+pics

		session[:content] = content

		redirect_to :edit_passage
	end	

	def edit_passage
		if session[:p_id] == nil
			session[:p_id] = params[:p_id]
		end
		@pass_edit = Passage.find(session[:p_id])
		if @pass_edit.passage == nil
			@pass_edit.passage = ""
			@pass_edit.save
		end
	end

	def save_passage
		pass_edit = Passage.find(session[:p_id])
		pass_edit.passage = params[:passage][:text]
		pass_edit.linebreak = params[:line]
		pass_edit.save
		
		session[:p_id] = nil
		
		redirect_to :move_up
		# redirect_to :edit_page
	end

	def delete_passage
		to_delete = Passage.find(params[:p_id])

		content = session[:content] 
		
		content.each do |c|
			if c.position > to_delete.position
				c.position -= 1
				c.save
			end
		end
		to_delete.destroy

		redirect_to :edit_page
	end


# GENERAL EDITING METHODS
	def move_up
		if session[:current_position] == nil
			session[:current_position] = params[:current_position]
		end
		if session[:move_to] == nil
			session[:move_to] = params[:move_to]
		end

		current_position = session[:current_position].to_i
		move_to = session[:move_to].to_i
		content = session[:content]

		content.each do |c|
			if c.position >= move_to && c.position < current_position
				c.position += 1
				c.save
			elsif c.position == current_position
				c.position = move_to
				c.save
			end
		end

		session[:current_position] = nil
		session[:move_to] = nil

		redirect_to :edit_page
	end

	def move_down
		if session[:current_position] == nil
			session[:current_position] = params[:current_position]
		end
		if session[:move_to] == nil
			session[:move_to] = params[:move_to]
		end

		current_position = params[:current_position].to_i
		move_to = params[:move_to].to_i
		content = session[:content]

		content.each do |c|
			if c.position <= move_to && c.position > current_position
				c.position -= 1
				c.save
			elsif c.position == current_position
				c.position = move_to
				c.save
			end
		end

		session[:current_position] = nil
		session[:move_to] = nil

		redirect_to :edit_page
	end
end