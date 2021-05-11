class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  attachment :profile_image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: following_id
  has_many :followings, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "Relationship", foreign_key: follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(user)
    followed.find_by(following_id: user.id).present?
  end


  validates :name,  uniqueness: true, length: {in: 2..20}
  validates :introduction, length: {maximum: 50}

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: "#{content}")
    elsif method == 'forward'
      User.where('name LIKE ?', "#{content}%")
    elsif method == 'backward'
      User.where('name LIKE ?', "%#{content}")
    else
      User.where('name LIKE ?', "%#{content}%")
    end
  end
end
