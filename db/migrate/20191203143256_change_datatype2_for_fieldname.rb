class ChangeDatatype2ForFieldname < ActiveRecord::Migration[5.0]
  def change
    change_column(:reviews, :review_official_student_deadline, :date)
    change_column(:reviews, :review_open_date, :date)
    change_column(:reviews, :review_student_input_date, :date)
    change_column(:reviews, :review_faculty_input_date, :date)
    change_column(:reviews, :ip_open_date, :date)
    change_column(:reviews, :ip_official_student_deadline, :date)
    change_column(:reviews, :ip_student_input_date, :date)
    change_column(:reviews, :ip_faculty_input_date, :date)
    change_column(:reviews, :ip_release_date, :date)
    change_column(:reviews, :dp_open_date, :date)
    change_column(:reviews, :dp_official_student_deadline, :date)
    change_column(:reviews, :dp_student_input_date, :date)
    change_column(:reviews, :dp_faculty_input_date, :date)
    change_column(:reviews, :dp_release_date, :date)
    change_column(:reviews, :review_release_date, :date)
  end
end
