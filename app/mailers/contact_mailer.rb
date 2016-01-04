class ContactMailer < ApplicationMailer
  def welcome_email(contact)
    @contact = contact
    @url  = 'https://grupjalan.herokuapp.com'
    mail(from: @contact.email, to: 'grupjalan@example.com', subject: 'Welcome to My Awesome Site')
  end
end
