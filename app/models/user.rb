class User < ApplicationRecord
    # mount_uploader :decision_letter, AttachmentUploader
    has_many :reviews
    self.primary_key=:uin
    
  def self.savepdf(params,temp)
      file = params.delete(:cover)
      temp=User.find_by(:uin => temp)
      if file
        temp.update_attributes(:fielname =>sanitize_filename(file.original_filename))
        temp.update_attributes(:content_type =>file.content_type)
        temp.update_attributes(:decision_let => file.read)
      end
     end
   def self.savepdf2(params,temp)
      file = params.delete(:cover)
      temp=User.find_by(:uin => temp)
      if file
        temp.update_attributes(:fieldname =>sanitize_filename(file.original_filename))
        temp.update_attributes(:content_typesr =>file.content_type)
        temp.update_attributes(:sturep => file.read)
      end
     end  
     
private
  def self.sanitize_filename(filename)
    # Get only the filename, not the whole path (for IE)
    # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
    return File.basename(filename)
  end
end
