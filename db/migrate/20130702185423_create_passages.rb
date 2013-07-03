class CreatePassages < ActiveRecord::Migration
  def change
    create_table :passages do |t|
    	t.integer :linebreak
    	t.integer :position
    	t.string :title
    	t.text :passage
    	t.integer :page_id
      	t.timestamps
    end
  end
end
