class ToppagesController < ApplicationController
  def index
    #@topics = Topic.all.order('created_at DESC').page(params[:page])
    
    @interest_sum = Topic.total_interest
    topics = Topic.find(@interest_sum.keys)
    @topics = Kaminari.paginate_array(topics).page(params[:page])
    
  end
end
