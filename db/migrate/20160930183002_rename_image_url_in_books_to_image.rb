class RenameImageUrlInBooksToImage < ActiveRecord::Migration
  def change
  	rename_column :books, :image_url, :image
  end
end
