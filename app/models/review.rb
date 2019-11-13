class Review < ApplicationRecord
    belongs_to :search
    
  def self.rev_func (revs)
     @rev=Review.includes(:search).where(:search_id => 327005544)
  end
end
