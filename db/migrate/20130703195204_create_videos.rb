class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
    	t.integer :linebreak
    	t.integer :position
    	t.string :title
    	t.string :url
    	t.integer :page_id
      t.string :description
      t.string :show_desc
      	t.timestamps
    end
  end
end
