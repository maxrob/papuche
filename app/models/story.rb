class Story < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_many :permissions, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user

  validates :title, :content, :user_id, presence: true
  validates :content, length: {
      minimum: 1,
      maximum: 10,
      tokenizer: lambda { |str| str.scan(/\s+|$/) },
  }

  before_save :add_begin_story

  # TODO vérifier limite par nom et pas par caractères


  def finished!
    self.finished = true
  end

  def self.all_finished
    Story.where(finished: true).order(created_at: :desc).includes(:messages, :user)
  end

  def self.all_unfinished
    Story.where(finished: false).order(created_at: :asc).includes(:messages, :user)
  end

  def self.random
    Story.all_finished.shuffle
  end

  def self.top_finished
    Story.where(finished: true).order(like: :desc).includes(:messages, :user)
  end

  private
  def add_begin_story
    self.content = 'Il était une fois ' + self.content
  end

end
