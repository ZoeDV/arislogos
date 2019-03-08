class Topic < ApplicationRecord

  validates :content, presence: true, length: { maximum: 255 }
  
  belongs_to :user
  has_many :posts
  #has_many :user_of_posts, through: :posts, source: :user
  
  def self.total_interest
    self.eager_load(posts: :interests).group(:id).order('count_interests_id DESC').count('interests.id')
  end
end
