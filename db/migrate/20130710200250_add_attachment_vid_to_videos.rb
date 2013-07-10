class AddAttachmentVidToVideos < ActiveRecord::Migration
  def self.up
    change_table :videos do |t|
      t.attachment :vid
    end
  end

  def self.down
    drop_attached_file :videos, :vid
  end
end
