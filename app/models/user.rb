class User < ApplicationRecord
  has_one_attached :profile_image
  has_many :events, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :comments, dependent: :destroy
  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
  #通知のリレーション
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'join_user_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'host_user_id', dependent: :destroy

  validates :email, presence: true, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpeg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  #フォロー通知
  def create_notification_follow(current_user)
      notification = current_user.active_notifications.new(
        host_user_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
  end

end
