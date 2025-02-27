class CreateReadingStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :reading_statuses do |t|
      t.integer :status, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :start_date
      t.date :completion_date

      t.timestamps
    end

    # ユーザーと本の組み合わせに対して一意の制約を追加
    add_index :reading_statuses, [ :user_id, :book_id ], unique: true
  end
end
