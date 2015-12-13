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


  def finished!
    self.update_attribute(:finished, true)
  end

  def self.all_finished
    Story.where(finished: true).order(created_at: :desc).includes(:messages, :user)
  end

  def self.all_unfinished
    Story.where(finished: false).order(created_at: :asc).includes(:messages, :user)
  end

  def self.random
    Story.where(finished: true).order('RANDOM()').includes(:messages, :user)
  end

  def self.top_finished
    Story.where(finished: true).order(like: :desc).includes(:messages, :user)
  end

end
