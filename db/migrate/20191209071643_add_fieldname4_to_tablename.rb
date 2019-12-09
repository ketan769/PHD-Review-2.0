class AddFieldname4ToTablename < ActiveRecord::Migration[5.0]
  def change
     add_column :reviews,:filename,:string
  end
end
