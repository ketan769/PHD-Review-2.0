class AuthMailer < ApplicationMailer
    def forgot_password(auth)
     @auth = auth
     @greeting = "Hi"
     mail to: auth.email, :subject => 'Reset password instructions'
    end
end
