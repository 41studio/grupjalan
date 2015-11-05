class MessagesController < ApplicationController

	def create
    if params[:group_id]
      
      message.group_id = params[:group_id]
    else
      user_id   = current_user.id
      to        = params[:user_id].to_i  
      members  = [user_id, to].sort
      members.sort!
      members.join('-')
      conversation = Conversation.find_or_create_by(members: members)
      user1 = current_user
      user2 = User.find(params[:message][:to])
      conversation.users << user1
      conversation.users << user2

      message = current_user.messages.build(message_params)
      message.conversation_id = conversation.id
    end

    if message.save
      flash[:success] = 'Pesan berhasil dibuat.'
    else
      flash[:danger]  = 'Pesan gagal dibuat.'
    end
    redirect_to :back
  end

  def index
    @user = User.find(params[:user_id])
    @messages = current_user.messages.where("messages.to = ?", @user.id) 
    @message = Message.new
  end

  def inbox
    @conversations = current_user.conversations
  end  


  # def create_personal
  #   @messages = current_user.messages.build(message_params)
  #   if @message.save
  #     flash[:primary] = 'Pesan kamu berhasil dikirim'
  #   else
  #     flash[:danger]  = 'Pesan kamu gagal dikirim'
  #   end
  #   redirect_to :back 
  # end  

  private
    def find_message
      @message = current_user.messages.find(params[:id])
    end


    def message_params
      params.require(:message).permit(:body, :group_id, :to, :user_id)
    end

end
