class AddIsReturnedToBorrowedBooks < ActiveRecord::Migration
  def change
  	add_column :borrowed_books, :isReturned, :boolean, default:false
  	add_column :borrowed_books, :userHasReturned, :boolean, default:false
  end
end
