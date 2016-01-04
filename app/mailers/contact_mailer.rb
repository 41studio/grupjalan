class ContactMailer < ApplicationMailer
   default from: 'notifications@example.com'

  def welcome_email(contact)
    @contact = contact
    @url  = 'http://lvh.me:3000/login'
    mail(to: @contact.email, subject: 'Welcome to My Awesome Site')
  end
end
