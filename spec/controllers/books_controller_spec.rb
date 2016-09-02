require 'rails_helper'


RSpec.describe BooksController, type: :controller do

  describe "POST #create" do
    context "with valid attributes" do
      it "create new book" do
        post :create, book: attributes_for(:book)
        expect(Book.count).to eq(1)
      end
    end
  end
end
