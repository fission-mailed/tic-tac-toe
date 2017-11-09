class Game
	attr_accessor :turns,:array
	
	def initialize
		@array = []
		9.times{@array.push(" ")}
		@turns = 0
	end

	def string_to_num(str)
		case str
		when "X"
			1
		when " "
			0
		when "O"
			-1
		end
	end
	
	def score
		@scores = @array.map{|str| string_to_num(str)}
		@row1 = @scores[0] + @scores[3] + @scores[6]
		@row2 = @scores[1] + @scores[4] + @scores[7]
		@row3 = @scores[2] + @scores[5] + @scores[8]
		@col1 = @scores[0] + @scores[1] + @scores[2]
		@col2 = @scores[3] + @scores[4] + @scores[5]
		@col3 = @scores[6] + @scores[7] + @scores[8]
		@diag1 = @scores[0] + @scores[4] + @scores[8]
		@diag2 = @scores[2] + @scores[4] + @scores[6]
		@totals = [@row1,@row2,@row3,@col1,@col2,@col3,@diag1,@diag2]
	end

	def display_board
		puts
		puts
		puts "#{"\t"*4}   A   B   C  "
		puts "#{"\t"*4}  #{"   |"*2}"
		puts "#{"\t"*4}1  #{@array[0]} | #{@array[3]} | #{@array[6]}"
		puts "#{"\t"*4}  #{"___|"*2}___"
		puts "#{"\t"*4}  #{"   |"*2}"
		puts "#{"\t"*4}2  #{@array[1]} | #{@array[4]} | #{@array[7]}"
		puts "#{"\t"*4}  #{"___|"*2}___"
		puts "#{"\t"*4}  #{"   |"*2}"
		puts "#{"\t"*4}3  #{@array[2]} | #{@array[5]} | #{@array[8]}"
		puts "#{"\t"*4}  #{"   |"*2}"
		puts		
	end
	
	def turn(tile, symbol)
		@array[tile] = symbol
		@turns += 1
	end
	
	def game_over?
		score
		if @totals.any?{|val| val == 3}
			puts "Player 1 wins!"
			true
		elsif @totals.any?{|val| val == -3}
			puts "Player 2 wins!"
			true
		elsif @turns > 8 && @totals.none?{|val| val == 3 || val == -3}
			puts "It's a draw!"
			true
		else
			false
		end
	end
end

play = true
while play
	game = Game.new
	str_array = ["a1","a2","a3","b1","b2","b3","c1","c2","c3"]

	puts "Player 1 will be 'X', Player 2 will be 'O'"
	puts "To select a tile, type in the name of the tile when it is your go."
	puts "For example to select the top left tile enter 'A1' or 'a1'"
	until game.game_over?
		symbol = " "
		if game.turns % 2 == 0
			game.display_board
			puts "Player 1's turn, please select an empty tile:"
			symbol = "X"
		else
			game.display_board
			puts "Player 2's turn, please select an empty tile:"
			symbol = "O"
		end
		input = gets.chomp.downcase
		valid = false
		str_array.each_with_index do |tile, index|
			if tile == input
				if game.array[index] == " "
					game.turn(index, symbol)
					valid = true
				else
					puts "This tile isn't empty"
				end
			end
		end
		unless valid
				puts "You didn't enter a valid tile."
		end
	end
	game.display_board
	puts "Do you want to play again?"
	input = gets.chomp.downcase
	if input == "yes" || input == "y" || input == "1"
		play = true
	elsif input == "no" || input == "n" || input == "0"
		play = false
	else
		puts "I'll assume you want to quit then."
		play = false
	end
end