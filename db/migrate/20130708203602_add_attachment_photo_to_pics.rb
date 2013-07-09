class AddAttachmentPhotoToPics < ActiveRecord::Migration
  def self.up
    change_table :pics do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :pics, :photo
  end
end
