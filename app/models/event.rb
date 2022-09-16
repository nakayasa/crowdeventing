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

    def create_notification_join(current_user)
	    notification = current_user.active_notifications.new(
        comment_id: nil,
        event_id: id,
	      host_user_id: user_id,
	      action: "join"
	    )
      if notification.join_user_id == notification.host_user_id
       notification.checked = true
      end
    notification.save if notification.valid?
  	end

  	def create_notification_comment(current_user, comment_id)
	    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
      temp_ids = Comment.where(event_id: id).select(:user_id).where.not("user_id = ? or user_id = ?", current_user.id, user_id).distinct
	    temp_ids.each do |temp_id|
	        save_notification_comment(current_user, comment_id, temp_id['user_id'])
        end
    	# まだ誰もコメントしていない場合は、投稿者に通知を送る
    	save_notification_comment(current_user, comment_id, user_id)
    end

  	def save_notification_comment(current_user, comment_id, host_user_id)
        # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
        notification = current_user.active_notifications.new(
          event_id: id,
          comment_id: comment_id,
          host_user_id: host_user_id,
          action: 'comment'
        )
        # 自分の投稿に対するコメントの場合は、通知済みとする
        if notification.join_user_id == notification.host_user_id
          notification.checked = true
        end
        notification.save if notification.valid?
     end

    def start_time #start_time以外の名前の開始時刻属性を持つモデルがある場合、またはリレーションシップを介してアクセスする場合は、my_model.rbファイルでstart_timeメソッドを定義することで属性のエイリアスを作成でき、上記のように個別に指定する必要はありません。」（Google翻訳ママ)
      self.date #self.の後はsimple_calendarに表示させるためのカラムを指定
    end

end
