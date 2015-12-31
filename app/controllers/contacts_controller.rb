class ContactsController < ApplicationController
  
  def create
  end

  def new
  end


  private
    def find_contact
    end
      
    def contact_params
      params.require(:contact).permit(:name, :email, :subject, :message, :user_id)
    end
end
