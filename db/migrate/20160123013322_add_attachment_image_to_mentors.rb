class AddAttachmentImageToMentors < ActiveRecord::Migration
  def self.up
    change_table :mentors do |t|
      t.has_attached_file :m_image
    end
  end

  def self.down
    drop_attached_file :mentors, :m_image
  end
end
