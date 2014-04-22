class Stock < ActiveRecord::Base
	has_many :deltas
	has_many :time_deltas
	validates :hashtag, :name , presence: true, :uniqueness => true, length: { minimum: 2 }
end
