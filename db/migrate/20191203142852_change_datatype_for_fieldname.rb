class ChangeDatatypeForFieldname < ActiveRecord::Migration[5.0]
  def change
    add_column(:users, :prelim_date, :date)
    add_column(:users, :qual_exam_date, :date)
  end
end
