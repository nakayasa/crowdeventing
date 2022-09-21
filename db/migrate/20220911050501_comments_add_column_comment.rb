class CommentsAddColumnComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :comment, :text  # commentカラムを追加
  end
end
