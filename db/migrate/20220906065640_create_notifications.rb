class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :join_user_id, null: false
      t.integer :host_user_id, null: false
      t.integer :event_id
      t.integer :comment_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :notifications, :join_user_id
    add_index :notifications, :host_user_id
    add_index :notifications, :event_id
    add_index :notifications, :comment_id
  end
end