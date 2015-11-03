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

  private
    def find_message
      @message = current_user.messages.find(params[:id])
    end


    def message_params
      params.require(:message).permit(:body, :group_id)
    end

end
