class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  validates :user_id, :story_id, presence: true

  def self.like!(story_id:, user_id:)
    self.find_or_create_by(story_id: story_id, user_id: user_id)
  end

  def self.dislike!(story_id:, user_id:)
    self.find_by(story_id: story_id, user_id: user_id).destroy
  end

end