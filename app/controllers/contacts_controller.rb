# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  subject    :string
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = current_user.contacts.new(contact_params)

    if @contact.save
      ContactMailer.welcome_email(@contact).deliver
 
      flash[:success] = 'Thank you for your message'
    else
      flash[:error] = 'Cannot send message.'
    end
    redirect_to root_path
  end



  private
      
    def contact_params
      params.require(:contact).permit(:name, :email, :subject, :message, :user_id)
    end
end
