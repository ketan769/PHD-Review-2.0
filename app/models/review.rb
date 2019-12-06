class Review < ApplicationRecord
    belongs_to :user
    
  def self.rev_func (revs)
     if revs!=""
        @rev=Review.includes(:user).where(:user_id => revs)
     else
        @rev=Review.includes(:user) 
     end
     return @rev
  end
end
