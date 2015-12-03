class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  validates :content, :user_id, :story_id, presence: true
  validates :content, length: {
      minimum: 1,
      maximum: 10,
      tokenizer: lambda { |str| str.scan(/\s+|$/) },
  },
  #TODO vérifier limite par nom et pas par caractères

end
