class Post < ApplicationRecord
  
  mount_uploader :image, ImageUploader
  
  validates :image, presence: true#, length: {maximum: 255}
  validates :content, presence: true, length: {maximum: 100}
  
  belongs_to :user
  belongs_to :topic
end
