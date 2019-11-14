class ChangeIntegerLimitInReviews < ActiveRecord::Migration[5.0]
  def change
    change_column :reviews, :uin, :integer, limit: 8
  end
end
