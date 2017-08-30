class AddAttachmentAvatarToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :avatar
      t.string :slug
    end
  end

  def self.down
    remove_attachment :projects, :avatar
  end
end
