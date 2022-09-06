class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :guest_user_id, null: false
      t.integer :host_user_id, null: false
      t.integer :event_id, null: false
      t.boolean :checked, null: false, default: "false"

      t.timestamps
    end
  end
end
