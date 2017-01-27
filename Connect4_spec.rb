require "Connect4.rb"
describe Game do
	before do
      @game = Game.new
    end
	
	describe "#initialize" do
			it "initializes board to be empty" do
			  42.times{|x| expect(@game.board[x].status).to eql("empty")}
			end
	end
end
