class AddFieldname3ToTablename < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :decision_let, :bytea
    add_column :reviews, :content_type,:string
    add_column :reviews, :file_contents,:string
    add_column :users, :sturep, :bytea
    add_column :users, :content_typesr,:string
    add_column :users, :file_contentsr,:string
  end
end
