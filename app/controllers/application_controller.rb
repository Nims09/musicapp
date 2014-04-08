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

  def renderArray(array)
    prettyJson = JSON.pretty_generate(array)
    render json: prettyJson
  end

  def printSomthingToRender(string)
		render text: string
	end
end
