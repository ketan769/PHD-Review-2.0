class Review < ApplicationRecord
    belongs_to :user
    
  def self.rev_func (revs)
     if revs!=""
        @rev=Review.includes(:user).where(:user_id => revs)
        # byebug
     else
        @rev=Review.includes(:user) 
     end
    #  byebug
     return @rev
  end
end
