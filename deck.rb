require_relative 'card.rb'

class Deck
	
	def shuffle
		@cards =  []	
		suits = ["\u2665","\u2663","\u2663","\u2666"]
		suits.each do |suit|
			(1..13).each do |rank|
				@cards.push(Card.new(suit,rank))
			end
		end
		@cards.shuffle!
		@cards.shuffle!
	end

	def draw_card
		return @cards.shift
	end
end