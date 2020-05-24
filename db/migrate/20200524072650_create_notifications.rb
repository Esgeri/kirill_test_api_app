class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :body
      t.datetime :push_time
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
