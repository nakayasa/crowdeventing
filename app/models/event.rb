class Event < ApplicationRecord
  belongs_to :genre, optional: true
  belongs_to :user, optional: true
  has_many :joins, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def joined_by?(user)
    joins.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    @event = Event.where("name LIKE?","%#{word}%")
  end

  def create_notification_by!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["join_user_id = ? and host_user_id = ? and event_id = ? and action = ? ", current_user.id, user_id, id, 'join'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        event_id: id,
        host_user_id: user_id,
        action: 'join'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.join_user_id == notification.host_user_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る(投稿にコメントしているユーザーIDのリストを取得する、自分のコメントは除外する、重複した場合は削除する)
    temp_ids = Comment.select(:user_id).where(event_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      event_id: id,
      comment_id: comment_id,
      host_user_id: user_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.join_user_id == notification.host_user_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
