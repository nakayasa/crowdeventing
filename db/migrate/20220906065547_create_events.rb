class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.text :body, null: false
      t.date :date, null: false
      t.time :start_at, null: false
      t.time :end_at, null: false
      t.string :location, null: false
      t.string :cost
      t.integer :recruit, null: false
      t.timestamps
    end
  end
end
