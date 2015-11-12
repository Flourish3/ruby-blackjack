require_relative 'card.rb'

class Person
	attr_accessor :cards
	def initialize
		@sum = 0
		@cards = []
	end
	
	def deal(card)
		@cards << card
		@sum = get_sum
		if @sum > 21
			cards.each do |card|
				if card.value == 11
					card.value = 1
				end
			end
			@sum = get_sum
		end		
	end

	def get_sum
		tmp_sum = 0
		@cards.each do |card|
			tmp_sum += card.value
		end
		return tmp_sum
	end 

	def get_cards
		return @cards
	end
end