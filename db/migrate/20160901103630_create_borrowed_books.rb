class CreateBorrowedBooks < ActiveRecord::Migration
  def change
    create_table :borrowed_books do |t|
      t.integer :user_id
      t.integer :book_id
      t.datetime :return_date

      t.timestamps null: false
    end
  end
end
