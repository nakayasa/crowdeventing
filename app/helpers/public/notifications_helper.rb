module Public::NotificationsHelper

  def notification_form(notification)
    @join_user = notification.join_user
    @comment = nil
    @join_user_comment = notification.comment_id
    case notification.action
    when 'follow'
      tag.a(notification.join_user.first_name, href: user_path(@join_user)) + 'があなたをフォローしました'
    when 'join'
      tag.a(notification.join_user.first_name, href: user_path(@join_user)) + 'が' + tag.a('あなたの投稿', href: micropost_path(notification.micropost_id)) + 'にいいねしました'
    when 'comment' then
      @comment = Comment.find_by(id: @join_user_comment)
      @comment_content =@comment.body
      @micropost_title =@comment.event.name
      tag.a(@join_user.first_name, href: user_path(@join_user)) + 'が' + tag.a("#{@event_name}", href: event_path(notification.event_id)) + 'にコメントしました'
    end
  end

end