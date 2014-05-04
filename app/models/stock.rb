class Stock < ActiveRecord::Base
	belongs_to :user
	has_many :deltas
	has_many :time_deltas, dependent: :destroy
	validates :hashtag, :name, :user, presence: true, length: { minimum: 2 }
end
