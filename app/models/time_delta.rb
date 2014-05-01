class TimeDelta < ActiveRecord::Base
	 # XXX These need to be improved to be smarter and learned
	 # --> REALLY need to train a model to do this correctly
  def self.vocabPositive
    ["good", "improvment", "great", "positive", "love", "dedicated", "live", "lives", "worked", "well", "accomplishment", "achievement", "affirmative", "appealing", "approve", "beneficial", "choice", "effective", "innovate", "intelligent", "lucky"]
  end
  def self.vocabNegative
    ["the", "if", "is", "than", "a", "bad", "worse", "terrible", "negative", "hate", "disinterested", "die", "dies", "disfunctioned", "badley"]
  end

	validates :start, :length, :final, :positive, :negative, :neutral, :total, presence: true
  belongs_to :stock
end
