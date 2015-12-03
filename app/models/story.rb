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
  },
  #TODO vérifier limite par nom et pas par caractères
  

end
