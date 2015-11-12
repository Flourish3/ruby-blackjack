require_relative 'person.rb'
require_relative 'deck.rb'
require_relative 'card.rb'

class Dealer < Person

	def initialize(deck)
		super()
		@deck = Deck.new
		@deck.shuffle
	end

	def hit(person)
		card = @deck.draw_card
		person.deal(card)
	end
end