class Search < ActiveRecord::Base
 has_many :reviews 
 def self.search_func (search)
   Search.joins(:reviews)
   if search[:uin]!=""
     
     temp=Search.where(:uin => search[:uin])
   else
     temp=Search
   end
   if search[:first_name]!=""
    temp=temp.where(:first_name => search[:first_name])
   end
   if search[:last_name]!=""
    temp=temp.where(:last_name => search[:last_name])
   end
   if search[:review_year]!=nil 
    temp=temp.where(:review_year => search[:review_year])
   end
  return temp 
 end
end

