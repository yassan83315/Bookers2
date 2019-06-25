class BooksController < ApplicationController

	before_action :authenticate_user!, only: [:index, :show, :edit]


	def index
		@user = current_user
		@book = Book.new
		@books = Book.all
	end

	def show
		@book = Book.new
		@book_content = Book.find(params[:id])
		@user = current_user
		@users = @book_content.user
	end

	def edit
		@user = current_user
		@book = Book.find(params[:id])
		# @book.user_id = current_user.id
		unless  @book.user_id == current_user.id
			redirect_to books_path
		end
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		flash[:notice] = "Book was successfully updated"
		redirect_to book_path(@book.id)
		else
		@user = current_user
		# @book = Book.find(params[:id])
		@book.user_id = current_user.id
		render "edit"
		end
	end

	def create
		@book = Book.new(book_params)
		# @book = Book.new
		# @book.title = params[:title]
		# @book.body = params[:body]
		@book.user_id = current_user.id
		if @book.save
		flash[:notice] = "You have created book successfully "
		redirect_to book_path(@book)
		else
		@user = current_user
		@books = Book.all
		render "index"
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	private
	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end

end
