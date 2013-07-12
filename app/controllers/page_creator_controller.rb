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
		if params[:page_id] != nil
			session[:page_id] = params[:page_id]
		end

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


# Picture Editing Functions

	def new_pic
		pic = Pic.new
		pic.page_id = session[:page_id]
		pic.def_size = 1
	 	pic.side = 0
	 	pic.position = params[:current_position]
	 	pic.linebreak = 0
	 	pic.save

	 	session[:pic_id] = pic.id
	 	session[:current_position] = params[:current_position]
		session[:move_to] = params[:move_to]

		passages = Passage.where(page_id: session[:page_id])
		videos = Video.where(page_id: session[:page_id])
		docs = Document.where(page_id: session[:page_id])
		pics = Pic.where(page_id: session[:page_id])
		content = passages+videos+docs+pics

		session[:content] = content

		redirect_to :edit_pic
	end

	def edit_pic
		if session[:pic_id] == nil
			session[:pic_id] = params[:pic_id]
		end
		@picture = Pic.find(session[:pic_id])
	end

	def save_pic
		picture = Pic.find(session[:pic_id])
		if params[:photo] != nil
			picture.photo = params[:photo]
		end
		picture.def_size = params[:def_size]
		picture.side = params[:side]
		picture.linebreak = params[:line]
		picture.description = params[:description]
		picture.show_desc = params[:show_desc]
		picture.save

		session[:pic_id] = nil
		
		redirect_to :move_up
	end

	def delete_pic
		to_delete = Pic.find(params[:pic_id])

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

# Document Editing Options
	def new_document
		document = Document.new
		document.title = "Untitled"
		document.page_id = session[:page_id]
		document.position = params[:current_position]
		document.save

		session[:doc_id] = document.id
	 	session[:current_position] = params[:current_position]
		session[:move_to] = params[:move_to]

		passages = Passage.where(page_id: session[:page_id])
		videos = Video.where(page_id: session[:page_id])
		docs = Document.where(page_id: session[:page_id])
		pics = Pic.where(page_id: session[:page_id])
		content = passages+videos+docs+pics

		session[:content] = content
		redirect_to :edit_document
	end	

	def edit_document
		if session[:doc_id] == nil
			session[:doc_id] = params[:doc_id]
		end
		@document = Document.find(session[:doc_id])
	end

	def save_document
		document = Document.find(session[:doc_id])
		if params[:doc] != nil
			document.doc = params[:doc]
		end
		document.title = params[:title]
		document.linebreak = params[:line]
		document.indent = params[:indent]
		document.description = params[:description]
		document.show_desc = params[:show_desc]
		document.save

		redirect_to :move_up
	end

	def delete_document
		to_delete = Document.find(params[:doc_id])

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

# Movie Editing Options
	def new_video
		video = Video.new
		video.page_id = session[:page_id]
		video.position = params[:current_position]
		video.save

		session[:vid_id] = video.id
	 	session[:current_position] = params[:current_position]
		session[:move_to] = params[:move_to]

		passages = Passage.where(page_id: session[:page_id])
		videos = Video.where(page_id: session[:page_id])
		docs = Document.where(page_id: session[:page_id])
		pics = Pic.where(page_id: session[:page_id])
		content = passages+videos+docs+pics

		session[:content] = content
		redirect_to :edit_video
	end	

	def edit_video
		if session[:vid_id] == nil
			session[:vid_id] = params[:vid_id]
		end
		@video = Video.find(session[:vid_id])
	end

	def save_video
		video = Video.find(session[:vid_id])
		if params[:vid] != nil
			video.vid = params[:vid]
		end
		video.linebreak = params[:line]
		video.description = params[:description]
		video.show_desc = params[:show_desc]
		video.save

		session[:vid_id] = nil

		redirect_to :move_up
	end

	def delete_video
		to_delete = Video.find(params[:vid_id])

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

	def show
		session[:page_id] = nil
		@pages = Page.where(user_id: current_user.id)
	end
end