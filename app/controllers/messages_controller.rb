class MessagesController < ApplicationController
  before_filter :find_message, only: [:create]

	def create
    
  end

  def index
    user_id   = current_user.id
    to        = params[:user_id].to_i  
    members   = [user_id, to].sort
    members.sort!
    members = members.join('-')

    @user = User.find(params[:user_id])
    @conversation = Conversation.find_or_create_by(members: members)
    @messages = @conversation.messages.includes(:user).order("created_at desc")
    @message  = Message.new
  end

  def inbox
    @conversations = current_user.conversations.includes(receiver: [:receiver])
  end  

  def destroy
    message = Message.find(params[:id])
    message.destroy
    flash[:success] = 'Message berhasil dihapus.'
    redirect_to :back
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

  def inbox
    @conversations = current_user.mailbox.conversations
    @messages = @conversations.first.messages.order(created_at: :asc)
  end

  private
    def find_message
      @message = current_user.messages.new
    end

    def message_params
      params.require(:message).permit(:body, :group_id, :to, :user_id)
    end

end
