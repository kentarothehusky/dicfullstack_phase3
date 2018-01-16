class ContactMailer < ApplicationMailer
 def contact_mail(contact)
 @contact = contact

 mail to: "ks.1984ever@gmail.com", subject: "お問い合わせの確認メール"
 end
end
