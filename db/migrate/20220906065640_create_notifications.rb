class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :join_user, null: false, foreign_key: { to_table: :users }
      t.references :host_user, null: false, foreign_key: { to_table: :users }
      t.references :event, null: true, foreign_key: true
      t.references :comment, null: true, foreign_key: true
      t.string :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
