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

class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :conversation
  validates_presence_of :body
end