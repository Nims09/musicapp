class QuerysController < ApplicationController
	# XXX Security commented for development
	#http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

	def new
	end

	def index
		@querys = Query.all
	end

	def create
		# getSomeTweets("twitterApi").each do |tweet|
		getTweets("goog", 0, 0).each do |tweet|
			@query = Query.new(:tweet => tweet["text"], :tweetId => tweet["id"])
			if !(@query.save)
				printSomthingToRender("Missing ID on tweet.")
			end
		end

		redirect_to @query 
	end	

	def show 
		@query = Query.find(params[:id])
	end

	def edit
		@query = Query.find(params[:id])
	end
end	