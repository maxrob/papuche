class Story < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_many :permissions, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user

  paginates_per 5

  validates :title, :content, :user_id, presence: true
  validates :content, length: {
      minimum: 1,
      maximum: 10,
      tokenizer: lambda { |str| str.scan(/\s+|$/) },
  }
  validates :content, length: { maximum: 240 }


  # TODO vérifier limite par nom et pas par caractères


  def finished!
    self.update_attribute(:finished, true)
  end

  def self.get(story_id:)
    Story.includes(:messages, :user, :likes).find(story_id)
  end

  def self.all_finished
    self.where(finished: true).order(created_at: :desc).includes(:messages, :user, :likes)
  end

  def self.all_unfinished
    self.where(finished: false).order(created_at: :asc).includes(:messages, :user, :likes)
  end

  def self.random
    self.where(finished: true).order('RANDOM()').includes(:messages, :user, :likes)
  end

  def self.top_finished
    self.where(finished: true).order(like: :desc).includes(:messages, :user, :likes)
  end

  def self.all_liked(user_id:)
    Story
        .joins(:likes)
        .where(["likes.user_id = ?", user_id])
        .order("likes.created_at DESC")
        .includes(:messages, :user, :likes)
  end

  def self.all_contributed(user_id:)
    Story
        .joins(:messages)
        .where(["messages.user_id = ?", user_id])
        .order("messages.created_at DESC")
        .includes(:messages, :user, :likes)
  end

end
