Conversation
hbtm :users
members:string:index
----------------------------------------------------------------------------


Message Group -> tidak ada converation_id




Message Personal -----------------------------------------------------------
sender_id = current_user
to_id = params[:id]
members = [sender_id, to_id].sort # [3,10] [10,3]
members.sort!
members = members.join!('-') # '3-10'

conversation = Conversation.find_or_create(members: members)
user1
user2

conversation.users << user1
conversation.users << user2
-----------------------------------------------------------------------------
















INBOX ---------------------------------------
@conversations = user.conversations


@conversations.each do |conversation|
	= converstation.members
-------------------------------------------
