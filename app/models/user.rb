class User < ApplicationRecord
  has_many :posts
  has_one_attached :avatar
  has_many :comments
  has_many :likes, dependent: :destroy

  has_many :requests,
           foreign_key: :requestor_id,
           class_name: :FriendRequest,
           dependent: :destroy
  has_many :received_requests,
           foreign_key: :receiver_id,
           class_name: :FriendRequest,
           dependent: :destroy

  has_many :friends, class_name: "User", foreign_key: "user_id"
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name # assuming the user model has a name
      #user.avatar = auth.info.image # assuming the user model has an image
    end
  end
end
