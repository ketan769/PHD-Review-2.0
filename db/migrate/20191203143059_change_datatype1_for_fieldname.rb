class ChangeDatatype1ForFieldname < ActiveRecord::Migration[5.0]
  def change
    change_column(:users, :qual_exam_date, :date)
    change_column(:users, :proposal_date, :date)
    change_column(:users, :final_exam_defence_date, :date)
  end
end
