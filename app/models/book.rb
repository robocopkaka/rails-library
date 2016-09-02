class Book < ActiveRecord::Base
	has_many :borrowed_books
	has_many :users, through: :borrowed_books
	validates_presence_of :name, :isbn,:author, :description, :quantity, :surcharge_fee
end
