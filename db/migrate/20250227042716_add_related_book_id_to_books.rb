class AddRelatedBookIdToBooks < ActiveRecord::Migration[8.0]
  def change
    add_reference :books, :related_book, null: true, foreign_key: { to_table: :books }
  end
end
