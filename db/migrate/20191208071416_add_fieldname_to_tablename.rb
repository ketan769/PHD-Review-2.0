class AddFieldnameToTablename < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :fielname,:string
    add_column :users, :content_type,:string
    add_column :users, :file_contents,:string
    
  end
end
