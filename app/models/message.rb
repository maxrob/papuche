class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  validates :content, :user_id, :story_id, presence: true
  validates :content, length: {
      minimum: 1,
      maximum: 10,
      tokenizer: lambda { |str| str.scan(/\s+|$/) },
  }
  #TODO vérifier limite par nom et pas par caractères

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