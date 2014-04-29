class TimeDeltasController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "sec", only: :destroy

  def create
    # XXX Add these columns to the model and populate them
    # finalRating, positiveTweets, negativeTweets, neutralTweets, totalTweets
    tweetRatings = {:finalRating => 0, :positiveTweets => 0, :negativeTweets => 0, :neutralTweets => 0} 
    @stock = Stock.find(params[:stock_id])
    tweets = getTweets(@stock.hashtag, time_delta_params[:start], time_delta_params[:length].to_i)
    tweets.each do |tweet|
      tweetRatings[:tweetCount] += 1
      case processTweet(tweet)
        when 1
          tweetRatings[:positiveTweets]  += 1
          tweetRatings[:finalRating]     += 1
        when -1
          tweetRatings[:negativeTweets]  += 1
          tweetRatings[:finalRating]     -= 1
        else 
          tweetRatings[:neutralTweets]   += 1
      end
    end
    @time_delta = @stock.time_deltas.create(time_delta_params)

    redirect_to stock_path(@stock)
  end

  def destroy
    @stock = Stock.find(params[:stock_id]) 
    @time_delta = @stock.time_deltas.find(params[:id])

    # @time_delta = @stock.time_deltas.create(time_delta_params)
    @time_delta.destroy
    redirect_to stock_path(@stock)
  end

  private 
    def time_delta_params
      params.require(:time_delta).permit(:start, :length)
    end

    def processTweet(tweet)
      # XXX This needs to be improved the way it processes the tweets, making better
      # better judgment calls on what positive and negative feedback for now it just 
      # uses a bank of 'good' and 'bad' words which don't accuratly reflect 
      feedback = 0
      text = tweet["text"].split(' ')

      text.each do |token|
        if TimeDelta.vocabPositive.include?(token)
          feedback += 1
        end

        if TimeDelta.vocabNegative.include?(token)
          feedback += 1
        end 
      end

      return feedback
    end
end