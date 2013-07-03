class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
    	t.string :title
    	t.string :URL
    	t.integer :user_id
      	t.timestamps
    end
  end
end