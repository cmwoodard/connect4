require 'colorize'
class Game
	attr_accessor :board, :game_over, :current_player, :winner
	def initialize
		@board = [[],[],[],[],[],[]]
		populate_board
		@winner = 1
		@game_over = false
		@color = "green"
		@current_player = 1
	end
	
	def populate_board
		@board.each{|x|
			(1..7).each{|y| x.push(Slot.new(y))}
			}
	end
	
	def draw_board
		#clear board, redraw
		system("cls")
		puts "     Connect 4      ".bold.red.on_white.blink
		print "\n---------------------\n"
		@board.each{|row|		
			row.each{|x| 
				if  (x.slot)  == 7
					print "|", x.owner.send(x.color).bold ,"|\n---------------------\n"			
				else
					print "|", x.owner.send(x.color).bold ,"|"
				end
		}
		}
		
		print " 1  2  3  4  5  6  7 \n\n"
	end

	def drop_piece(column)
		cur_row = 5
		column = column-1
		placed = false
		
		while placed == false && cur_row >= 0
			if @board[cur_row][column].owner == " "							
				
				@board[cur_row][column].owner = current_player.to_s
				@board[cur_row][column].set_adjacents(cur_row, column, board)			
				
				if @current_player == 1
					@board[cur_row][column].color = "red"					
					@current_player = 2
				else
					@board[cur_row][column].color = "yellow"
					@current_player = 1
				end				
				
				placed = true
			else
				cur_row -= 1
			end
		end
	end	
	
	def win_check
		@board.each_with_index{|row, rindex|
	
			row.each_with_index{|column, cindex|
				begin
					if board[rindex][cindex].down.owner == board[rindex][cindex].owner && board[rindex][cindex].down.down.owner == board[rindex][cindex].owner && board[rindex][cindex].down.down.down.owner == board[rindex][cindex].owner
						@game_over = true						
					end
					rescue
				end
				
				begin
					if board[rindex][cindex].right.owner == board[rindex][cindex].owner && board[rindex][cindex].right.right.owner == board[rindex][cindex].owner && board[rindex][cindex].right.right.right.owner == board[rindex][cindex].owner
						@game_over = true
					end
					rescue
				end
				
				begin
					if board[rindex][cindex].br.owner == board[rindex][cindex].owner && board[rindex][cindex].br.br.owner == board[rindex][cindex].owner && board[rindex][cindex].br.br.br.owner == board[rindex][cindex].owner
						@game_over = true
					end
					rescue
				end
				begin
					if board[rindex][cindex].bl.owner == board[rindex][cindex].owner && board[rindex][cindex].bl.bl.owner == board[rindex][cindex].owner && board[rindex][cindex].bl.bl.bl.owner == board[rindex][cindex].owner
						@game_over = true
					end
					rescue
				end
				
			}
		}
		draw_board
	end
	
end

class Slot
	attr_accessor :slot, :status, :color, :owner, :right, :down, :br, :bl
	def initialize(slot)
		@slot = slot
		@owner = " "
		@color = "green"
		@status = "empty"
		@left = nil
		@ul = nil
		@right = nil
		@ur = nil
		@top = nil
		@br = nil
		@down = nil
		@bl = nil
	end
	
	def set_adjacents(row, column, board)

		begin
			@right = board[row][column+1]
		rescue
		end
		begin
			@br = board[row+1][column +1]
		rescue
		end
		begin
			@bl = board[row+1][column -1]
		rescue
		end
		begin
			@down = board[row+1][column]
		rescue
		end
	end
end

play_again = true
while play_again == true
	game = Game.new
	while game.game_over == false
		game.draw_board
		
		puts "Where would you like to put a piece?"
		answer = gets.chomp.to_i
		
		if answer > 0 && answer < 8
			game.drop_piece(answer)
		end
		game.win_check
	end
	winner = 1
	
	if game.current_player == 1
		winner = 2
	else
		winner =1
	end
	puts "Player #{winner} has won!"
	
	puts "Would you like to play again?(y/n)"
	reply = gets.chomp
	if reply == "y"
		play_again = true
	else
		play_again = false
	end
end

