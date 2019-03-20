class User < ApplicationRecord
  before_save {self.email.downcase!}
  
  mount_uploader :image, ImageUploader
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: {maximum: 255},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :sex, presence: true
  has_secure_password
  
  has_many :topics
  has_many :posts
  #has_many :commented_topics, through: :posts, source: :topic
  
  has_many :interests
  has_many :interested_posts, through: :interests, source: :post
  
  has_many :agrees
  has_many :agree_posts, through: :agrees, source: :post
  
  has_many :disagrees
  has_many :disagree_posts, through: :disagrees, source: :post
  
  def agree(post)
    self.agrees.find_or_create_by(post_id: post.id)
    
    disagree= self.disagrees.find_by(post_id: post.id)
    disagree.destroy if disagree
  end
  
  def del_agree(post)
    agree = self.agrees.find_by(post_id: post.id)
    agree.destroy if agree
  end
  
  def agree?(post)
    self.agree_posts.include?(post)
  end
  
  def disagree(post)
    self.disagrees.find_or_create_by(post_id: post.id)
    
    agree = self.agrees.find_by(post_id: post.id)
    agree.destroy if agree
  end
  
  def del_disagree(post)
    disagree= self.disagrees.find_by(post_id: post.id)
    disagree.destroy if disagree
  end
  
  def disagree?(post)
    self.disagree_posts.include?(post)
  end

end
