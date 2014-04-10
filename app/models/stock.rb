class Stock < ActiveRecord::Base
	validates :hashtag, :name , presence: true, :uniqueness => true, length: { minimum: 2 }
end
