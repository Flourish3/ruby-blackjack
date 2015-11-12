require_relative 'game_motor.rb'
 
new_game = true
gm = Game_motor.new
gm.start
gm.new_round
while new_game
	print "\n\n\nPlay again?(y/n)"
	ans = gets.chomp
	if ans == "y"
		gm.new_round
		new_game = true
	else
		new_game = false
		puts "Thank you for playing"
	end
end
