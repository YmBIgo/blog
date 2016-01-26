class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|

      t.integer    :venture_id
      t.integer    :mentor_id
      t.integer    :genre_id
      t.boolean    :has_read, default: false
      t.text       :content
      t.text       :answer_content
      t.timestamps null: false

    end
  end
end
