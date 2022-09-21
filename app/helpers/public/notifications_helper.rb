module Public::NotificationsHelper
  def notification_form(notification)
    @join_user = notification.join_user
    @comment = nil
    @join_user_comment = notification.comment_id
    @join_user_event = notification.event_id
    @join_user_name = @join_user.last_name + @join_user.first_name
    case notification.action
    when "follow"
      tag.a(@join_user_name, href: user_path(@join_user)) + "さんがあなたをフォローしました"
    when "join"
      @event = Event.find_by(id: @join_user_event)
      tag.a(@join_user_name, href: user_path(@join_user)) + "さんが" + tag.a("#{@event.name}(#{@event.date})", href: event_path(notification.event_id)) + "に参加しました"
    when "comment" then
      @comment = Comment.find_by(id: @join_user_comment)
      @event = @comment.event
      tag.a(@join_user_name, href: user_path(@join_user)) + "さんが" + tag.a("#{@event.name}(#{@event.date})", href: event_path(notification.event_id)) + "にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
