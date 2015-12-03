class Story < ActiveRecord::Base
  has_many :messages
  has_many :permissions
  has_many :likes
  belongs_to :user

  validates :title, :content, :user_id, presence: true
  validates :content, length: {
      minimum: 1,
      maximum: 10,
      tokenizer: lambda { |str| str.scan(/\s+|$/) },
  }

  # TODO vérifier limite par nom et pas par caractères

  def finished!
    self.finished = true
  end

  def self.all_finished
    Story.where(finished: true).includes(:messages, :user)
  end

  def self.all_unfinished
    Story.where(finished: false).includes(:messages, :user)
  end

  def self.random
    Story.all_finished.shuffle
  end

end
