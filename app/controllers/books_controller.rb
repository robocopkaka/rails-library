class BooksController < ApplicationController
	require 'rest-client'
	before_action :admin, only: [:new, :edit]
	def new
		@book = Book.new
	end

	#function to create a new book
	def create
		@book = Book.new(book_params)
		respond_to do |format|
			if @book.save
				format.html{redirect_to @book}
				format.json{render :show, status: :created, location: @book}
			else
				format.html{render :new}
				format.json{render json: @book.errors, status: :unprocessible_entity}
			end
		end
	end

	def edit
		@book = Book.find_by_id(params[:id])
	end

	def update
		@book = Book.find_by_id(params[:id])
		respond_to do |format|
			if @book.update_attributes(book_params)
				redirect_to @book
			else
				render 'edit'
			end
		end
	end

	def show
		@book = Book.find_by_id(params[:id])
	end

	def index
		@books = Book.all.limit(2)
	end

	def all_books
		@books = Book.all
	end

	#initial implementation for borrow
	# doesn't check if a user has borrowed a particular book before
	# add that feature later
	def borrow
		@book = Book.find(params[:book_id])
		if user_signed_in?
			if(!BorrowedBook.exists?({user_id: current_user.id, book_id: @book.id}))
				if (@book.isAvailable && @book.quantity >= 1)
					@book.decrement!(:quantity, 1)
					if(@book.quantity == 0)
						@book.update_attributes(isAvailable:false)
					end
					current_user.borrowed_books.create(book: @book)
					BorrowedBook.last.update_attributes(return_date: BorrowedBook.last.created_at + 7.days)
					redirect_to @book
					flash[:success] = "Yaay! You've borrowed a book! Make sure you return it when due"
				else
					flash[:error] = "Book isn't available"
				end
			else
				redirect_to @book
				flash[:warning] = "You've borrowed this book before"
			end
		else
			redirect_to new_user_session_path
		end
	end

	def bestsellers
		url = 'https://api.nytimes.com/svc/books/v3/lists/best-sellers/history.json'
		response = RestClient.get(url, {params: {"api-key" => "e8d78bf70d704f218a49195e256d25b2"}})
		@books =  JSON.parse(response.body)
	end

	def destroy
		Book.find(params[:id]).destroy
  		flash[:success] = "Book deleted"
  		redirect_to root_url
	end

	private
	def book_params
	  params.require(:book).permit(:name, :isbn, :author, :description, :quantity, :surcharge_fee, :category_id, :image)
	end

	def admin
		if(!current_user.isAdmin)
			redirect_to root_path
		end
	end
end
