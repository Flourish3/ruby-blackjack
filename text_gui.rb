require_relative 'deck.rb'
require_relative 'person.rb'
require_relative 'player.rb'
require_relative 'dealer.rb'
require_relative 'card.rb'

require_relative 'states.rb'

class Game_gui
	include States
	def start
		puts "Welcome to BlackJack"
		print "How many players are threre?"
		nbr = gets.chomp.to_i
		while nbr == 0
			print "\nEnter a valid, non-zero number:"
			nbr = gets.chomp.to_i
		end
		return nbr
	end

	def add_players(nbr) #Return array of players
		players = []
		for i in 1..nbr
			print "Name of player #{i}?"
			name = gets.chomp
			players << Player.new(name)
		end
		return players
	end

	def take_bet(player) #return bet from player
		print "\nBet for #{player.name}:"
		bet = gets.chomp.to_i
		while bet == 0
			print "\nEnter a valid non-zero bet:"
			bet = gets.chomp.to_i
		end 
		return bet
	end

	def show_cards(player,dealer)
		#system("cls")
		puts "\n \nDealer"
		for i in 0..dealer.get_cards.count-1
			print "#{dealer.cards[i]} \t"
		end

		print "\t Sum: #{dealer.get_sum}"
			if dealer.get_sum > 21
				print "\t Dealer bust!"
			end

		player.each do |player|
			puts "\n#{player.name}"
			for i in 0..player.get_cards.count-1
				print "#{player.cards[i]} "
			end

			print "\t Sum: #{player.get_sum}"
			if player.get_sum > 21
				print "\t Player bust!"
			end
		end
	end

	def ask_player(player)
		print "\n#{player.name}, hit?(y/n)"
		answer = gets.chomp
		if answer == "y"
			return true
		end
		return false
	end

	def show_end_score(players,dealer,states)
		for i in 0..players.count-1
			puts ""
			case states[i]
			when States::Player_blackjack
				puts "#{players[i].name} has blackjack, wins 1,5x the money"
				puts "Won #{players[i].bet}x1,5 = #{players[i].bet*1.5} and now has #{players[i].money}"
			when States::Player_lose
				puts "#{players[i].name} lost, lose all the money"
				puts "Lost #{players[i].bet} and now has #{players[i].money}"
			when States::Player_wins
				puts "#{players[i].name} wins 1x the money"
				puts "Won #{players[i].bet} and now has #{players[i].money}"
			when States::Draw
				puts "It's a draw between dealer and #{players[i].name}"
				puts "Players money is restored, now has #{players[i].money}"
			end
		end
	end
end