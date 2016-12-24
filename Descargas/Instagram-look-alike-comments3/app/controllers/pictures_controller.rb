class PicturesController < ApplicationController
	before_action :find_pic, only: [:show, :edit, :update, :destroy, :upvote]
	before_action :authenticate_user!, except: [:index, :show]
	# authenticate it's so that only the users that aren't signed in can do the actions stated

	def index
		@pics= Picture.all.order("created_at DESC")
	end
	def new
		@pic= current_user.pictures.build
		# this will create the picture always associated with the current user
	end

	def create
		@pic= current_user.pictures.build(pic_params)
		if @pic.save
			redirect_to @pic, notice: "Yess it was posted"
		else
			render "new"
			# we don't want here a redirect because redicrect refreshes the page and 
			# we don't want to lose the content if we refresh the page
		end
	end
	def show

		
	end
	def edit
		
	end
	def update
		if @pic.update(pic_params)
			redirect_to @pic, notice: "The picture was updated"
		else
			render "edit"
		end
	end
	def destroy
		@pic.destroy
		redirect_to root_path
	end
	def upvote
		@pic.upvote_by current_user
		redirect_to :back
	end

	private
	def pic_params
		params.require(:picture).permit(:title, :description, :image)
		
	end
	def find_pic
		@pic= Picture.find(params[:id])
		
	end
end
