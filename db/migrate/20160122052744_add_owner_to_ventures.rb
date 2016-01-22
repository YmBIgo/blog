class AddOwnerToVentures < ActiveRecord::Migration
  def change
    add_column :ventures,     :owner,     :integer
  end
end
