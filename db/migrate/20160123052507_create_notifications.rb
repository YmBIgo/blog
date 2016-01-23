class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|

      t.integer    :type_id
      t.integer    :user_id
      t.integer    :mentor_id
      t.integer    :venture_id
      t.integer    :coaching_id

      t.timestamps null: false

    end
  end
end
