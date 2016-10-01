#This class holds actions for returning all borrowed books
#, along with the user that borrowed it
# Consider putting actions for borrow and return here,
# to de-congest the Books controller
class BorrowedBooksController < ApplicationController
	#return books borrowed by a particular user
	def user_borrowed_books
		@books = BorrowedBook.includes(:book, :user).where("user_id = ?", current_user.id).all
	end

	#return all borrowed books and the user that borrowed them
	def all_borrowed_books
		#use includes to join the borrowed_books, books, and users tables
		#includes takes in the model names in singular forms
		# I think joins uses the plural forms for the table names passes as parameters
		# to access any element of the books/ users tables in the views, do:
		# @iteration_variable.book.property or @iteration_variable.user.property 
		@books = BorrowedBook.includes(:book, :user)
	end

	def user_return_book
		@book = BorrowedBook.where("user_id = ? and book_id = ? and \"userHasReturned\" = ?", current_user.id, params[:book_id], false).first

		@book.update_attributes(userHasReturned: true)
		redirect_to user_borrows_path
	end

	def return_book
		@returning_book = Book.find(params[:book_id])
		@returning_book.increment!(:quantity, 1)
		if(@returning_book.quantity == 1)
			@returning_book.update_attributes(isAvailable: false)
		end
		@book = BorrowedBook.where("user_id = ? and book_id = ? and \"userHasReturned\" = ?", params[:user_id], params[:book_id], true).first
		@book.update_attributes(isReturned: true)
		redirect_to borrows_path
	end
end
