class CreateVentures < ActiveRecord::Migration
  def change
    create_table :ventures do |t|

      t.string            :name
      t.text              :explain
      t.text              :reason
      t.text              :vision
      t.text              :job_offer

      t.timestamps null: false
    end
  end
end
