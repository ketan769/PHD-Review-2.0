class ChangeDataTypeForFieldname < ActiveRecord::Migration[5.0]
  def change
    change_column(:user, :prelim_date, :date)
  end
end