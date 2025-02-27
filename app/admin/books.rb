ActiveAdmin.register Book do
  # 表示する列の設定
  index do
    selectable_column
    id_column
    column :title
    column :author
    column :isbn
    column :published_date
    column :total_pages
    column :format
    column :publisher
    column :created_at
    actions
  end

  # フィルター設定
  filter :title
  filter :author
  filter :isbn
  filter :published_date
  filter :format, as: :select, collection: Book::FORMATS

  # フォーム設定
  form do |f|
    f.inputs do
      f.input :title
      f.input :author
      f.input :isbn
      f.input :published_date, as: :datepicker
      f.input :total_pages
      f.input :description
      f.input :publisher
      f.input :format, as: :select, collection: Book::FORMATS
      f.input :related_book, collection: Book.all.map { |b| [ b.title, b.id ] }
    end
    f.actions
  end

  # 詳細画面のカスタマイズ
  show do
    attributes_table do
      row :id
      row :title
      row :author
      row :isbn
      row :published_date
      row :total_pages
      row :description
      row :publisher
      row :format
      row :related_book
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  # 許可するパラメータ
  permit_params :title, :author, :isbn, :published_date, :total_pages,
                :description, :publisher, :format, :related_book_id
end
