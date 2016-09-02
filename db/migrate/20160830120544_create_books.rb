class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :isbn
      t.string :author
      t.string :description
      t.string :image_url
      t.integer :quantity
      t.string :surcharge_fee
      t.boolean :isAvailable, default: true

      t.timestamps null: false
    end
  end
end
