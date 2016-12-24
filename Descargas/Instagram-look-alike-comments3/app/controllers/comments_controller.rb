class CommentsController < ApplicationController
	before_action :find_comment

	def new
		
		@comment= Comment.new
		
	end
	def create
		
		@comment= Comment.new(comment_params)
		@comment.picture_id= @pic.id
		@comment.user_id= current_user.id

		if @comment.save
			redirect_to picture_path(@pic)
			# @pic is the id that is needed in order to access the picture_path
			# then, in the view of picture show I could see the pictures which is stored in the db by:
			# <% current_user.pictures.find(@pic.id).comments.each do |comment| %>
			# <%= comment.comment %>
			# <% end %>
		else
			render "new"
			# by rendering here the page doesn't refresh so the input of the comments 
			# that we were putting we won't lose, whereas with redirect_to yes
			
		end
	end
	def destroy
		@comment= Comment.find(params[:id])
		@comment.destroy
		redirect_to picture_path(@pic)
		
	end


	private

	def comment_params
		params.require(:comment).permit(:comment)
	end
	def find_comment
		@pic= Picture.find(params[:picture_id])
		
	end
end
