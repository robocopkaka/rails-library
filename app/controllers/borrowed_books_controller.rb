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
end
