require_relative 'deck.rb'
require_relative 'person.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'card.rb'

require_relative 'states.rb'
require_relative 'text_gui.rb'


class Game_motor
	include States
	def initialize
		@gui = Game_gui.new
		@deck = Deck.new
	end

	def start
		@nbr_of_players = @gui.start
		@dealer = Dealer.new(@deck)
		@players = @gui.add_players(@nbr_of_players)
	end

	def new_round
		reset
		for i in 0..1
			@players.each do |player|
				if i == 0
					bet = @gui.take_bet(player)	
					while player.money - bet < 0
						puts "Not enough money.."
						bet = @gui.take_bet(player)
					end
					player.bet = bet
					player.money -= bet		
				end
				@dealer.hit(player)
			end
		end
		@dealer.hit(@dealer)
		@gui.show_cards(@players,@dealer)
		ask_players
		play_dealer
		check_conditions
	end

	def reset
		@deck.shuffle
		@dealer.cards = []
		@players.each do |player|
			player.cards = []
			player.bet = 0
		end
	end

	def ask_players
		@players.each do |player|
			if !(player.get_sum == 21 and player.cards.count == 2)
				while @gui.ask_player(player) do
					@dealer.hit(player)
					@gui.show_cards(@players,@dealer)
					if player.get_sum > 21 
						break
					end
				end
				@gui.show_cards(@players,@dealer)
			end
		end
	end

	def play_dealer
		count = 0
		@players.each do |player|
			if player.get_sum > 21
				count +=1
			end
		end
		all_players_bust = false
		if count > 0
			all_players_bust = true
		end

		if !all_players_bust
			while @dealer.get_sum < 17 do
				@dealer.hit(@dealer)
			end
			@gui.show_cards(@players,@dealer)
		end
	end

	def check_conditions
		dealer_sum = @dealer.get_sum
		dealer_has_blackjack = false
		if dealer_sum == 21 and @dealer.cards.count == 2
			dealer_has_blackjack = true
		end
		players_states = []
		@players.each do |player|
			player_sum = player.get_sum
			player_has_blackjack = false
			if player_sum == 21 && player.cards.size == 2
				player_has_blackjack = true
			end

			if (player_has_blackjack and !dealer_has_blackjack)
				players_states << States::Player_blackjack
				player.money += player.bet*2.5
			elsif (player_sum > dealer_sum and player_sum < 22 and dealer_sum < 22) or (dealer_sum > 21 and player_sum <22)
				players_states << States::Player_wins
				player.money += player.bet*2
			elsif  (player_sum == dealer_sum and player_sum < 22 and dealer_sum < 22) or (player_has_blackjack and dealer_has_blackjack) or (player_sum > 21 and dealer_sum > 21)
				players_states << States::Draw
				player.money += player.bet
			elsif (!player_has_blackjack and dealer_has_blackjack) or (dealer_sum > player_sum and player_sum < 22 and dealer_sum < 22) or (player_sum > 21 and dealer_sum < 22)
				players_states << States::Player_lose
			end
		end
		@gui.show_end_score(@players,@dealer,players_states)
	end
end