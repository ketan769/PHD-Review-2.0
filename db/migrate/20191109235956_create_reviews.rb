class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, index: true
      t.integer :review_id
      t.string :reviewer
      t.integer :user_id
      t.integer :year
      t.integer :review_score
      t.string :notes
      t.string :comments_for_faculty
      t.string :comments_for_student
      t.timestamp :review_open_date
      t.timestamp :review_official_student_deadline
      t.timestamp :review_student_input_date
      t.timestamp :review_faculty_input_date
      t.timestamp :ip_open_date
      t.timestamp :ip_official_student_deadline
      t.timestamp :ip_student_input_date
      t.timestamp :ip_faculty_input_date
      t.timestamp :ip_release_date
      t.timestamp :dp_open_date
      t.timestamp :dp_official_student_deadline
      t.timestamp :dp_student_input_date
      t.timestamp :dp_faculty_input_date
      t.timestamp :dp_release_date
      t.timestamps
    end
  end
end
