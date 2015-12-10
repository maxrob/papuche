class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  validates :content, :user_id, :story_id, presence: true
  validates :content, length: {
      minimum: 1,
      maximum: 10,
      tokenizer: lambda { |str| str.scan(/\s+|$/) },
  }

  def self.someone_writing?(story_id:)
    #TODO: use var define in config
    last_writer_timestamp = Time.now - 30
    !( Permission.where("story_id = :story_id AND updated_at >= :last_writer_timestamp", {:story_id => story_id, :last_writer_timestamp => last_writer_timestamp}).first.nil? )
  end

  def self.user_already_contribute?(user_id:, story_id:)
    ( Story.find(story_id).user_id == user_id ) || !( self.find_by(story_id: story_id, user_id: user_id).nil? )
  end

  def self.get_story_content(story_id:)
    story_content = Story.find(story_id).content


    stories = Message.where(story_id: story_id)
    if stories
      stories.each do |message|
        story_content += ' ' + message.content
      end
    end

    story_content
  end

end