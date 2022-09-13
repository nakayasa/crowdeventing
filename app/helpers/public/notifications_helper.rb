module Public::NotificationsHelper

   def notification_form(notification)
	  @join_user = notification.join_user
	  @comment = nil
	  your_event = link_to 'あなたの投稿', users_event_path(notification), style:"font-weight: bold;"
	  @join_user_comment = notification.comment_id
	  #notification.actionがfollowかjoinかcommentか
	  case notification.action
	    when "follow" then
	      tag.a(notification.join_user.first_name, href:users_user_path(@join_user), style:"font-weight: bold;")+"があなたをフォローしました"
	    when "join" then
	      tag.a(notification.join_user.first_name, href:users_user_path(@join_user), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_event_path(notification.event_id), style:"font-weight: bold;")+"にいいねしました"
	    when "comment" then
	    	@comment = Comment.find_by(id: @join_user_comment)&.content
	    	tag.a(@join_user.first_name, href:users_user_path(@join_user), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_event_path(notification.event_id), style:"font-weight: bold;")+"にコメントしました"
	  end
	end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end
