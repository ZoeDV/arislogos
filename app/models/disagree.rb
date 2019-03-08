class Disagree < Interest
  def self.counting
   self.group(:post_id).order('count_post_id DESC!').count(:post_id)
  end
end
