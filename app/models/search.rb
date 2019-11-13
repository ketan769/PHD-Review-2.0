class Search < ActiveRecord::Base
 has_many :reviews 
 self.primary_key=:uin

 def self.search_func (search)
   if search[:uin]!=""
     temp=Search.joins(:reviews).where(:uin => search[:uin]).distinct
     # byebug
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

