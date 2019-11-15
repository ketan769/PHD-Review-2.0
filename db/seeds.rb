# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
users= [{:uin => 327005544, :first_name => 'Ketan', :last_name=> 'sethi',:review_year =>2018,:gender => "Male",:cumul_gpa => 4.0 ,:degree_plan_date => "2019-11-13",:qual_exam_result => 'Pass'},
          {:uin =>327010110, :first_name => 'ABC', :last_name=> 'DEF',:review_year =>2019,:gender => "Female",:cumul_gpa => 4.0 ,:degree_plan_date => "2019-11-13",:qual_exam_result => 'Fail'}]
users.each do |ser|
  User.create!(ser)
end

reviews= [{:review_id =>7891, :user_id =>327010110, :year =>2019,:review_score =>'IMP',:comments_for_faculty =>"Great",:review_official_student_deadline =>"2019-11-13",:review_open_date =>"2019-12-13", :reviewer => "HC"},
          {:review_id =>7928, :user_id =>327005544, :year =>2019,:review_score =>'Sat',:comments_for_faculty =>"Bad",:review_official_student_deadline =>"2019-11-13",:review_open_date =>"2019-12-13", :reviewer => "Hark"},
          {:review_id =>7928, :user_id =>327005544, :year =>2018,:review_score =>'Gud',:comments_for_faculty =>"OK",:review_official_student_deadline =>"2019-11-13",:review_open_date =>"2019-12-13", :reviewer => "Harshita"}]

reviews.each do |rev|
  Review.create!(rev)
end

auths= [{:username => 123, :password=> 'abc', :email=> 'dola16shaw@gmail.com',:role =>2018},
          {:username =>327, :password=> 'def', :email=> 'DEF',:role =>2019}]
auths.each do |ser|
Auth.create!(ser)
end