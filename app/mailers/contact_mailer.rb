class ContactMailer < ApplicationMailer
    def contact_mail(picture)
       @picture = picture
       mail to: @picture.user.email, subject:"画像が投稿されました！"
    end
end
