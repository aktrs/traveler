class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :posts, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :follower, class_name: "Relationship", foreign_key: "follower_id" , dependent: :destroy
         has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
         has_many :following_user, through: :follower, source: :followed
         has_many :follower_user, through: :followed, source: :follower
         has_many :view_counts, dependent: :destroy
         has_many :messages, dependent: :destroy
         has_many :entries, dependent: :destroy
         has_many :relationships, foreign_key: :follower_id, dependent: :destroy
         has_many :following, through: :relationships, source: :followed
         has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :followed_id, dependent: :destroy
         has_many :followers, through: :reverse_of_relationships, source: :follower



         attachment:profile_image
         validates :name, presence: true

         def follow(user_id)
          follower.create(followed_id: user_id)
         end

         def unfollow(user_id)
          follower.find_by(followed_id: user_id).destroy
         end

         def following?(user)
          following_user.include?(user)
         end
        end
