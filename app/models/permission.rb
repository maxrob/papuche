class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  validates :user_id, :story_id, presence: true

  def self.timeout?(user_id:, story_id:)
    last_writer_timestamp = Time.now - Rails.configuration.x.custom['writing_time']
    Permission.where('story_id = :story_id AND user_id = :user_id AND updated_at >= :last_writer_timestamp',
                        {story_id: story_id, user_id: user_id, last_writer_timestamp: last_writer_timestamp}).first.nil?
  end
end
