# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  body            :text
#  conversation_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  group_id        :integer
#  to              :integer
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_group_id         (group_id)
#  index_messages_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_273a25a7a6  (user_id => users.id)
#

class MessagesController < ApplicationController
  
	def create
    recipient = User.find(params[:recipient_id])
    message = current_user.send_message(recipient, params[:body], params[:subject])

    flash[:success] = 'Pesan terkirim.'
    redirect_to inbox_url
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

  def destroy
    message = Message.find(params[:id])
    message.destroy
    flash[:success] = 'Message berhasil dihapus.'
    redirect_to :back
  end  

  def inbox
    @conversations = current_user.mailbox.conversations
  end

  def show
    conversation = Mailboxer::Conversation.find(params[:id])
    @messages = Mailboxer::Message.conversation(conversation).includes(:sender, :conversation).order(created_at: :asc)
  end

  def reply
    conversation = Mailboxer::Conversation.find(params[:conversation_id])
    current_user.reply_to_conversation(conversation, params[:body])
    
    flash[:success] = 'Pesan berhasil dibalas.'
    redirect_to inbox_url
  end

  def new
    @recipient = User.find params[:recipient_id]
  end

  private
    def message_params
      params.require(:message).permit(:body, :group_id, :to, :user_id)
    end
end
