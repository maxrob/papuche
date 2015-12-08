class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :whiny => false, styles: {
      medium: "300x300>", thumb: "100x100>",
      :url  => "/assets/images/avatars/:id.:extension",
      :path => ":rails_root/publicassets/images/avatars/:id.:extension"
  }, default_url: "/assets/images/avatars/default.jpg"

  validates_uniqueness_of :nickname
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
