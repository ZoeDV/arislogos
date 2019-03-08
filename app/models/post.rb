class Post < ApplicationRecord
  
  mount_uploader :image, ImageUploader
  
  validates :image, presence: true#, length: {maximum: 255}
  validates :content, presence: true, length: {maximum: 100}
  
  belongs_to :user
  belongs_to :topic
  
  has_many :interests
  has_many :interested_users, through: :interests
  
  has_many :agrees
  has_many :agree_users, through: :agrees, source: :user
  
  has_many :disagrees
  has_many :disagree_user, through: :disagrees, source: :user
  
  #def self.total_interest
  #  self.joins('LEFT JOIN interests ON post_id = posts.id').group(:topic_id).order('count_type DESC').count(:type)
  #  #self.joins(:interests).group(:topic_id).order('count_type DESC').count(:type)
  #end
 
end
