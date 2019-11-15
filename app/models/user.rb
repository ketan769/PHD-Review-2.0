class User < ApplicationRecord
    has_many :review
    self.primary_key=:uin
end
