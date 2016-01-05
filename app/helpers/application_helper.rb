module ApplicationHelper
  def get_name
    if user_signed_in?
      current_user.full_name
    else
      nil
    end  
  end

  def get_email
    if user_signed_in?
      current_user.email
    else
      nil
    end
  end      
end
