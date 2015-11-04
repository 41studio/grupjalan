class MessagesController < ApplicationController

	def create
    @message = current_user.messages.build(message_params)
    @message.group_id = params[:group_id]
    if @message.save
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


  def create_personal
    @messages = current_user.messages.build(message_params)
    if @message.save
      flash[:primary] = 'Pesan kamu berhasil dikirim'
    else
      flash[:danger]  = 'Pesan kamu gagal dikirim'
    end
    redirect_to :back 
  end  

  private
    def find_message
      @message = current_user.messages.find(params[:id])
    end


    def message_params
      params.require(:message).permit(:body, :group_id, :to)
    end

end
