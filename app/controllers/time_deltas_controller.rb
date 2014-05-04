class TimeDeltasController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "sec", only: :destroy
  before_filter

  def create
    # XXX Add these columns to the model and populate them
    # finalRating, positiveTweets, negativeTweets, neutralTweets, totalTweets
    tweetRatings = {:finalRating => 0, :positiveTweets => 0, :negativeTweets => 0, :neutralTweets => 0} 
    @stock = Stock.find(params[:stock_id])
    tweets = getTweets(@stock.hashtag, time_delta_params[:start], time_delta_params[:length].to_i)
   
    tweets.each do |tweet|
      proccessedTweet = processTweet(tweet)
      if proccessedTweet > 0 then
        tweetRatings[:positiveTweets] += 1
      elsif proccessedTweet < 0 then
        tweetRatings[:negativeTweets] += 1
      else 
        tweetRatings[:neutralTweets]  += 1
      end
      tweetRatings[:finalRating] += proccessedTweet
    end

    params['time_delta'][:final]      = tweetRatings[:finalRating]
    params['time_delta'][:positive]   = tweetRatings[:positiveTweets]
    params['time_delta'][:negative]   = tweetRatings[:negativeTweets]
    params['time_delta'][:neutral]    = tweetRatings[:neutralTweets]
    params['time_delta'][:total]      = tweets.count
    
    @time_delta = @stock.time_deltas.create(time_delta_params)
    redirect_to stock_path(@stock)
  end

  def destroy
    @stock = Stock.find(params[:stock_id]) 
    @time_delta = @stock.time_deltas.find(params[:id])
    @time_delta.destroy
    redirect_to stock_path(@stock)
  end

  private 
    def time_delta_params
      params.require(:time_delta).permit(
        :start, 
        :length,
        :final, 
        :positive, 
        :negative, 
        :neutral, 
        :total
        )
    end

    def processTweet(tweet)
      # XXX This needs to be improved the way it processes the tweets, making better
      # better judgment calls on what positive and negative feedback for now it just 
      # uses a bank of 'good' and 'bad' words which don't accuratly reflect 
    
      feedback = 0
      text = tweet["text"].split(' ')
      retweetCountOffset = tweet["retweet_count"]
      if retweetCountOffset = 0 
        retweetCountOffset = 1
      end
      userFollowersCountOffset = tweet["user"]["followers_count"]
      if userFollowersCountOffset = 0
        userFollowersCountOffset = 1
      end   

      text.each do |token|
        if TimeDelta.vocabPositive.include?(token)
          feedback += 1
        end

        if TimeDelta.vocabNegative.include?(token)
          feedback -= 1
        end 
      end

      return (feedback * (retweetCountOffset * userFollowersCountOffset))
    end
end