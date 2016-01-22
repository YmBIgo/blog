class AddAttachmentVImageToVentures < ActiveRecord::Migration
  def self.up
    change_table :ventures do |t|
      t.has_attached_file :v_image
    end
  end

  def self.down
    drop_attached_file :ventures, :v_image
  end
end
