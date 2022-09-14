class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) } #デフォルトの並び順を「作成日時の降順」で指定
  belongs_to :event, optional: true #nilを許可
  belongs_to :comment, optional: true #nilを許可
  belongs_to :join_user, class_name: 'User', optional: true #nilを許可
  belongs_to :host_user, class_name: 'User', optional: true #nilを許可
end
