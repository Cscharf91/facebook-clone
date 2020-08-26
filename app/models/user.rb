class User < ApplicationRecord
  has_many :posts
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
         :recoverable, :rememberable, :validatable
end
