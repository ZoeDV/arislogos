class Topic < ApplicationRecord

  validates :content, presence: true, length: { maximum: 255 }
  
  belongs_to :user
  has_many :posts
  #has_many :user_of_posts, through: :posts, source: :user
end
