require_relative 'person.rb'

class Player < Person
	attr_accessor :money, :bet
	attr_reader :name
	def initialize(name)
		super()
		@name = name
		@money = 100
	end
end