class Auth < ApplicationRecord
    has_secure_password
    def send_password_reset
        generate_token(:password_reset_token)
        self.password_reset_sent_at = Time.zone.now
        save!
        AuthMailer.forgot_password(self).deliver_now# This sends an e-mail with a link for the user to reset the password
    end
# This generates a random password reset token for the user
    def generate_token(column)
     begin
        self[column] = SecureRandom.urlsafe_base64
     end while Auth.exists?(column => self[column])
    end
end
