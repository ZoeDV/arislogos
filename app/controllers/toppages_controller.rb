class ToppagesController < ApplicationController
  def index
    @topics = Topic.all.order('created_at DESC').page(params[:page])
  end
end
