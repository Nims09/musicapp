class TimeDelta < ActiveRecord::Base
	validates :start, :length , presence: true
  belongs_to :stock
end
