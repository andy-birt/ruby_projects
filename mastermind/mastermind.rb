class Game

  @@legend = ["Green", "Red", "White"]
  

  def initialize
    @nums = ["1","2","3","4","5","6"]
    @solved = [nil, nil, nil, nil]
    @broken = false
    @mode = initialize_game
    puts "\n"
    maker_mode if @mode == "1"
    breaker_mode if @mode == "2"
    guess_code
  end

  def breaker_mode
    @code = generate_code
  end

  def maker_mode
    @code = create_code
  end

  def compare(g,c)
    correct = 0
    count = 0
    guesses = g.split("")
    codes = c.split("")
    # puts "#{c}"
    
    g.split("").each_with_index do |guess, i|      

      if guess == c[i]
        
        puts "#{guess}: #{@@legend[0]}"
        @solved[i] = guess
        correct += 1
        @broken = correct == 4 ? true : false
      elsif c.include?(guess)

        if guesses.count(guess) > c.count(guess)

          puts "#{guess}: #{@@legend[2]}"              
          guesses[i] = nil
          
        else
          puts "#{guess}: #{@@legend[1]}"
        end
        
        correct = 0
      
      else
        puts "#{guess}: #{@@legend[2]}"
        correct = 0
      end

      # puts "#{@solved}"
      

    end

    
    # puts "#{g}"

  end

  def computer_guess
    generate_code
  end
  
  def create_code
    puts "Enter a four digit code with each digit ranging between 1-6:"
    return gets.chomp
  end

  def initialize_game
    puts "\n\n"
    puts "Welcome to Mastermind"
    puts "\n\n"
    puts "The objective of the game is to break the code"
    puts "which is a set of four colors represented as numbers (bewteen 1-6)."
    puts "\nThe game has two players: Codemaker and Codebreaker"
    puts "\nThe codemaker makes a sequence of numbers that the codebreaker has to guess."
    puts "The codemaker wins if the codebreaker does not correctly guess the code."
    puts "If the codebreaker correctly guesses the numbers in the \ncorrect order then codebreaker wins."
    puts "\nPick four numbers between 1-6 and press enter"
    puts "\nYour numbers will generate a color:"
    puts "\nWhite means number doesn't exist"
    puts "Red means number exists but has a different spot"
    puts "Green means its the right number in the right spot"
    puts "\nChoose your destiny ( 1: Codemaker | 2: Codebreaker )"
    # puts "\nPress enter to continue"
    return gets.chomp
  end

  def generate_code
    code = []
    while code.size < 4 do
      code << rand(1..6)
    end
    code.join("")
  end

  def guess_again(g)

    red_nums = []
    
    guesses = g.split("")
    
    guess_code = g.split("").map.with_index do |guess, i|
          
      if guess == @code[i]
        @nums.delete(guess) if @solved.count(guess) == @code.count(guess)
        guess = guess
      elsif @code.include?(guess)
        # puts "guesses[#{i}] == #{guess}"

        red_nums << guess

        red_nums.uniq!
        
        @nums.delete(guess) if @solved.count(guess) == @code.count(guess)

        # puts "nums: #{@nums}"
        # puts "red_nums: #{red_nums}"
        if red_nums.count(guess) == @code.count(guess)
          red_nums.delete(guess)
          guess = @nums.sample
        else
          guess = red_num.sample
        end
      else
        @nums.delete(guess) if @solved.count(guess) == @code.count(guess)
        guess = @nums.sample
      end

    end.join("")
  
  end

  def guess_code
    
    code = @code
    guesses = 10
    first_guess = guesses
    
    while guesses > 0
      
      puts "You have #{guesses} guesses." if guesses > 1
      puts "You have #{guesses} guess left!!!" if guesses == 1
      puts "Enter the number combination:"
      
      if @mode == "1"
        guess = computer_guess if guesses == first_guess
        guess = guess_again(guess) if guesses < first_guess
        gets
      else      
        guess = gets.chomp
      end
      
      puts "\n"
      
      compare(guess, code)
      
      puts "\n"
      
      guesses -= 1 if guess.size == 4
      
      break if @broken
    
    end
    
    if @broken
      puts "You broke the code!!!"
    else
      puts "Sorry you ran out of guesses."
      puts "The code was #{code}"
    end
 
  end

end

Game.new