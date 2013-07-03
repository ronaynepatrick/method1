class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
    	t.integer :linebreak
    	t.integer :position
    	t.string :title
    	t.string :url
    	t.integer :page_id
      t.timestamps
    end
  end
end
