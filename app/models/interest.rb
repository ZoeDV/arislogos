class Interest < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  def self.ranking
    self.group(:post_id).order('count_id DESC').limit(3).count(:id)
  end
end
