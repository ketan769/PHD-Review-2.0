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
    def self.savepdf(params)
      file = params.delete(:cover)
      temp=Review.find_by(:user_id => params[:tempid] ,:year => params[:tempid2])
      if file
        
        temp.update_attributes(:filename =>sanitize_filename(file.original_filename))
        temp.update_attributes(:content_type =>file.content_type)
        temp.update_attributes(:decision_let => file.read)
      end
    end
        
    private
    def self.sanitize_filename(filename)
        # Get only the filename, not the whole path (for IE)
        # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
        return File.basename(filename)
    end

end

