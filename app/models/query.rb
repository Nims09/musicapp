class Query < ActiveRecord::Base
	validates :tweetId, presence: true, length: {minimum: 5}
end
