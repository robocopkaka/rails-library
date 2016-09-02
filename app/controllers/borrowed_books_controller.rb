#This class holds actions for returning all borrowed books
#, along with the user that borrowed it
# Consider putting actions for borrow and return here,
# to de-congest the Books controller
class BorrowedBooksController < ApplicationController
	#return books borrowed by a particular user
	def user_borrowed_books
		@books = current_user.books
	end

	#return all borrowed books and the user that borrowed them
	def all_borrowed_books
		@books = BorrowedBook.joins(:books)
	end
end
