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

  def getTweets(hashtag, start, length) 
    client = getClient
    someTweets = []
    searchHashTag = "#" + hashtag + " -rt"
    endDate = concatenateDateRange(start, length)

    client.search(
      searchHashTag, 
      :result_type => "recent",  
      :lang => "en", 
      :since => start,
      :until =>  endDate,
    ).take(5).collect do |tweet|
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
      valuesArray = start.split('-')

      # Check we have a correct string
      if valuesArray.length != 3
        return "f"
      end

      # Continue adding days from the length and validating at each step
      while length > 0
        valuesArray[2] = incrementAndReturnAsString(valuesArray[2], 1 )
        length -= 1

        # Validate and increase month/year where necessary
        for count in [1,0]
          if (!validateDate(arrayToStringAsDate(valuesArray)))
            valuesArray[count] = incrementAndReturnAsString(valuesArray[count], 1)
            valuesArray[(count+1)] = "01"
          end
        end
      end

      return arrayToStringAsDate(valuesArray)
    end

    def validateDate(date)
      Date.parse(date)
      return true
    rescue
      return false
    end

    def arrayToStringAsDate(array)
      returnString = ""
      for count in 0..(array.length-1)
        if count != (array.length-1)
          returnString += (array[count] + "-")
        else
          returnString += array[count]
        end
      end
      return returnString
    end

    def incrementAndReturnAsString(original, value)
      originalAsInt = original.to_i
      originalAsInt += value
      if originalAsInt < 10
        return ("0" + originalAsInt.to_s)
      else
        return originalAsInt.to_s
      end
    end
end
