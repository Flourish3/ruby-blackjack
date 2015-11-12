class Card
	attr_reader :suit, :rank
	attr_accessor :value
	
	def initialize(suit,rank)
		@suit = suit
		@rank = rank			 	 
		dressed_cards = [11,12,13]
		if (dressed_cards.include?(rank))
			@value = 10
		elsif (rank == 1)
			@value = 11
		else
			@value = rank
		end
	end

	def to_s
		if rank == 11
		 	"#{@suit}Kn"
		elsif rank == 12
			"#{@suit}Q"
		elsif rank == 13
			"#{@suit}K"
		elsif rank == 1
			"#{@suit}A"
		else
			"#{@suit}#{rank}"
		end
	end
end