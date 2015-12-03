class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :content
      t.integer :like
      t.integer :user_id
      t.boolean :finished

      t.timestamps null: false
    end
  end
end
