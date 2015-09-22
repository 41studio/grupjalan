class PostMailer < ActionMailer::Base

  def post_created(user)

  	mail(to: user.email,
  		   from: "services@gandawijaya.com",
  		   subject: "Post Created",
  		   body: "Thank you your shop is a created"
  	)

  end

end
