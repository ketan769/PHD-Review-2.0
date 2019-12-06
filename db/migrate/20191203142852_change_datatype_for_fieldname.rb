class ChangeDatatypeForFieldname < ActiveRecord::Migration[5.0]
  def change
    change_column(:users, :prelim_date, :date)
    change_column(:users, :qual_exam_date, :date)
  end
end
