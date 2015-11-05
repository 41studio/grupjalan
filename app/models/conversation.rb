# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  members    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_conversations_on_members  (members)
#

class Conversation < ActiveRecord::Base
  has_and_belongs_to_many :users
end
