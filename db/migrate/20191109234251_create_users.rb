class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :uin
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :major
      t.string :degree
	    t.date :prelim_date
	    t.string :review_year
	    t.decimal :cumul_gpa
	    t.date :degree_plan_date
	    t.date :qual_exam_date
	    t.string :qual_exam_result
	    t.date :prelim_date
	    t.date :proposal_date
	    t.date :final_exam_defence_date
	    t.datetime :created_at, :null => false
	    t.datetime :updated_at, :null => false
	    t.string :fieldname
	    t.string :advisor
	    t.string :start_semester
	    t.string :decision_letter
	    t.string :fielname
	    t.string :content_type
	    t.string :file_contents
	    t.binary :decision_let
	    t.binary :sturep
	    t.string :content_typesr
	    t.string :file_contentsr
      t.timestamps
	  
    end
  end
end