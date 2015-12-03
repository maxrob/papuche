class UpdateStory < ActiveRecord::Migration
  def change
    change_column :stories, :like, :integer, default: 0
    change_column :stories, :finished, :boolean, default: false
  end
end
