class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def getClient
    config = {
      :consumer_key       => "LfSjQC9lnIDvl8jdNq5Sg",
      :consumer_secret    => "bJBWLJbQzqv1wzAR9DqoKmHPuSK8CweviUUMCMsSWjk",
      :access_token       => "262060561-jwTGye3OunvnfIQ1m3rlB8g8MGGLrD0zZcxatOXx",
      :access_token_secret=> "wLCMKcEnpDFdSnri9mLvze1pugvT26bubXfbSQlMMNmxx",
    }

    # XXX This needs validation and protection
    return Twitter::REST::Client.new(config)
  end

  def getSomeTweets(user)
    client = getClient
    someTweets = []
    client.user_timeline(user).each do |tweet| 
      someTweets.push(tweet)
    end

    return someTweets
  end

  def getTweets(hashtag, start, length) # It's not getting hash tags properly for some reason
    client = getClient
    someTweets = []
    searchHashTag = "#" + hashtag + " -rt"

    client.search(
      searchHashTag, 
      :result_type => "recent", 
      :lang => "en", :since => start, 
      :until => concatenateDateRange(start,length)
    )).take(5).collect do |tweet|
      someTweets.push(tweet)
    end

    return someTweets
  end

  def renderArray(array)
    prettyJson = JSON.pretty_generate(array)
    render json: prettyJson
  end

  def printSomthingToRender(string)
		render text: string
	end

  private 
    def concatenateDateRange(start, length)
      day   = 2
      month = 1
      year  = 0
      valuesArray = start.split('-')

      # Check we have a correct string
      if valuesArray.length != 3
        return "failed"
      end

      # Increase the last value
      currentInt = valuesArray[day].to_i
      currentInt += length

      if currentInt > 31
        valuesArray[day] = "00"
        currentInt = valuesArray[month]
        currentInt++

        if currentInt > 12
          valuesArray[month] = "00"
          currentInt = valuesArray[year]
          valuesArray[year]++
        else
          valuesArray[month] = currentInt.to_s
        end
      else
        valuesArray[day] = currentInt.to_s
      end

      returnString = ""
      for valuesArray.each do |val|
        # XXX load the return string
      end

      return 
    end


end
