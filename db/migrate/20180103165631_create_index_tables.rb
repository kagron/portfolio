class CreateIndexTables < ActiveRecord::Migration[5.0]
  def change
    create_table :about do |t|
      t.string :title
      t.text :content
      t.string :resume_file
      t.timestamps
    end
  end
end
