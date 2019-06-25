class UsersController < ApplicationController

	before_action :authenticate_user!

	before_action :connecting_user, only: [:edit, :update]

	def index
		# @user = User.find(params[:id])
		@user = current_user
		@book = Book.new
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@book = Book.new
		@books = Book.where(user_id: params[:id])
		# @books = @user.books
	end

	def edit
		@user = User.find(params[:id])
	end
	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		flash[:notice] = "User was successfully updated"
		redirect_to user_path(@user.id)
		else
		# redirect_to edit_user_path(@user.id)
		render "edit"
		@user = current_user
		end
	end

	def create
	end

	def destroy
		flash[:notice] = "logout"
	end

	private
		def user_params
			params.require(:user).permit(:name, :introduction, :profile_image)
		end

		def connecting_user
			if current_user.id != params[:id].to_i
				redirect_to user_path(current_user)
			end
		end

end
