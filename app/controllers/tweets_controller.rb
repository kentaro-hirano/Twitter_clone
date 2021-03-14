class TweetsController < ApplicationController
  def index
    @tweets = Tweet.includes(:user).order('created_at DESC')
  end
  
  def new
    @tweet = Tweet.new
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      flash[:notice] = "投稿に成功しました"
      redirect_to tweets_path
    else
      flash[:notice] = "投稿に失敗しました"
      render :new
    end
  end
  
  private
  def tweet_params
    params.require(:tweet).permit(:text).merge(user_id: current_user.id)
  end
end
