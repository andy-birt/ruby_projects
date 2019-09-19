class Game

  @@board = [[1,2,3],[4,5,6],[7,8,9]]
  @@winning_moves = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  @@moves = {}

  def initialize
    @winner = false
    display_char
    while @player_1.moves.size < 5
      display_cell
      break if @winner
    end
    puts "Welp, it's a draw, whaddaya know..." unless @winner
  end

  def check_winner
    @@winning_moves.each_with_index do |w, i|
      declare_winner if w & @current_player.moves.sort == w
    end
  end

  def declare_winner 
    @winner = true
    puts "#{@current_player.name} is the winner, HOORAYY!!" 
  end

  def make_players char
    @player_1 = Player.new("Player 1", char)
    @player_2 = Player.new("Player 2", char == "x" ? "o" : "x")
    puts "#{@player_1.name} has chosen #{char.upcase}!"
    puts "#{@player_2.name} will be #{@player_2.char.upcase}'s'"
  end

  def draw_board move=0
    moves = @@moves
    board = @@board
    @current_player.moves << move unless @current_player.moves[0] == 0
    @current_player.moves[0] = move if @current_player.moves[0] == 0
    moves[@current_player.char.upcase] = @current_player.moves
    puts "\n"
    board.each_with_index do |r, i|
      case move
      when 1,4,7
        r[0] = @current_player.char.upcase if r[0] == move
      when 2,5,8
        r[1] = @current_player.char.upcase if r[1] == move
      when 3,6,9
        r[2] = @current_player.char.upcase if r[2] == move
      else
        nil
      end
      puts " #{r[0]} | #{r[1]} | #{r[2]}"
      puts "-----------" unless i == 2
    end
    puts "\n"
  end

  def display_char
    puts "Enter your choice (X's or O's)"
    choice = gets.chomp.downcase
    unless choice == "x" || choice == "o"
      display_char
    else
      make_players(choice)
      turn
      draw_board
    end
  end

  def display_cell
    puts "#{@current_player.name}, Enter between 1-9 to choose your mark"
    choice = gets.chomp
    if choice =~ /^[1-9]$/
      draw_board(choice.to_i)
      check_winner
      turn
    else
      display_cell
    end
  end

  def turn
    @current_player = @current_player == @player_1 ? @player_2 : @player_1
  end

end

class Player
  attr_reader :name, :char, :moves
  def initialize name, char, moves=[]
    @name = name
    @char = char
    @moves = moves
  end
end

Game.new