# README
## Description
> This app tries to automate basic processes shared across libraries,  
like adding books to the library, and allowing users borrow and return  
books.

## Installation
> Clone or download this repo, navigate to the folder in your terminal,  
and run `bundle install --without production`

## Dependencies
* NodeJs - install to avoid an ExecJs error common with Rails 4.2.x versions

## Controllers
### Book Controller
#### Actions
* new - renders a view for adding new books. 
* create - saves a new book to the database.
* edit - renders a view for editing a book.
* update - updates a book's attributes
* show - renders a view for a particular book
* destroy - deletes a book from the database
* borrow - allows a user borrow a book
* bestsellers - used this to test retrieving books via New York Times' API

### BorrowedBook Controller
#### Actions
* user_borrowed_books - retrieves all books that a particular user has borrowed, and passes it to the view.  
I use `includes` to do an inner join on the users, books, and borrowed_books tables
* all_borrowed_books - retrieves all borrowed books.  
I use `includes` to do an inner join on the users, books, and borrowed_books tables
* user_return_book - allows a user return a book. Note that this does not update the `quantities` column in the books table. 
* return_book - allows the admin complete the return process for any borrowed book.  
This updates the `quantities` column in the books table.

### OmniauthCallbacks Controller
#### Actions
* facebook - handles callbacks for when trying to login through Facebook.