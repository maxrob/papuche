class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar,
                    {
                        whiny:        false,
                        styles:       {medium: "300x300>", thumb: "100x100>"},
                        default_url:  "/assets/images/avatars/default.jpg",
                        path:         "public/assets/images/avatars/:style/:hash.:extension",
                        url:          "/assets/images/avatars/:style/:hash.:extension",
                        hash_secret:  "b1e0dc8bf196c6e0b2370fc354516537ca617f86"

                    }


  validates_uniqueness_of :nickname
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
