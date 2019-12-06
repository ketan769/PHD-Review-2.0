class ChangeDataType3ForFieldname < ActiveRecord::Migration[5.0]
  def change
    change_column(:users, :cumul_gpa, :decimal)
  end
end
