class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :isbn
      t.date :published_date
      t.integer :total_pages
      t.text :description
      t.string :publisher

      t.timestamps
    end
    add_index :books, :isbn, unique: true
    add_index :books, :title
    add_index :books, :author
  end
end
