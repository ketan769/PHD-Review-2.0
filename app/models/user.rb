class User < ApplicationRecord
    # mount_uploader :decision_letter, AttachmentUploader
    has_many :reviews
    self.primary_key=:uin
end
