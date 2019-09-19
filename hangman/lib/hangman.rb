require_relative "gallow"

class Game

  attr_accessor :word, :number_of_guesses, :guesses, :solved

  include Gallow

  def initialize
    init_game
  end

  def init_game
    system("clear")
    puts "                              Welcome to Hangman"
    puts "                        1. New game   |   2. Continue game"
    option = gets.chomp
    new_game if option == "1"
    load_game if option == "2"
  end

  def play_game
    while @number_of_guesses > 0
      
      guess_letter
      
      break if @solved
    end
    if @number_of_guesses == 0
      system("clear")
      Gallow.all_wrong
      puts "                        You lost..."
      puts "                        The word was #{@word}"
      try_again
    elsif @solved
      puts "                        You solved the word!\n"
      try_again
    end
  end

  def try_again
    puts "                        Would you like to play again?"
    puts "                                  ( y | n )"
    try_again = gets.chomp.downcase
    new_game if try_again == "y"
  end

  def new_game

    @solved = false
    @guesses = []
    @number_of_guesses = 6
    @word = get_word.downcase

    play_game
    
  end

  def load_game
    props = []
    saved_game = File.open("save_game.txt", "r")
    saved_game.each do |line|
      props << line
    end
    
    @word, @number_of_guesses, @guesses = props[0], props[1].to_i, props[2].split("")

    play_game

  end

  def select_save_game
  end

  def save_game
    save = File.open("save_game.txt", "w")
    save.puts "#{@word}"
    save.puts "#{@number_of_guesses}"
    save.puts "#{@guesses.join("")}"
    save.close
    puts "                        Saved game..."
  end

  def guess_letter
    guess = ""
    hidden = @word.split("")
    system("clear")

    puts "              Would you like to save game? (y) or press any key to continue."

    save = gets.chomp

    save_game if save == "y"

    system("clear")

    case @number_of_guesses
    when 6
      Gallow.no_wrong
    when 5
      Gallow.one_wrong
    when 4
      Gallow.two_wrong
    when 3
      Gallow.three_wrong
    when 2
      Gallow.four_wrong
    when 1
      Gallow.five_wrong
    end
    
    hidden.map! do |c|
      unless @guesses.any?(c)
        c = "_"
      else
        c
      end
    end
    puts "                                  #{hidden.join(" ")}\n\n"

    @solved = true if hidden.join("") == @word

    while guess.size != 1
      break if @solved
      puts "\n                                Guess one letter\n"
      guess = gets.chomp.downcase
      @guesses << guess
    end
    check_guess guess
  end

  def check_guess guess
    unless @guesses.count(guess) < 2 && @word.include?(guess)
      puts @guesses.count(guess)
      @number_of_guesses -= 1
    end
  end

  def get_word
    words = []

    File.open("5desk.txt", "r") do |f|
      f.each do |word|
        words << word.strip if word.strip.length >= 5
      end
    end

    words.sample
  end
end

Game.new