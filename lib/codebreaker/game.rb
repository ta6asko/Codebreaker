require "codebreaker/version"

module Codebreaker
  class Game
    attr_accessor 

    def initialize
      @attemps = 10
      @output, @secret_code, @user_code_array = [], [], []
      @score = {}
    end

    def game
      new_game
      puts "Please enter your name"
      @user_name = gets.chomp
      @attemps.times do |i| 
        check_hint
        output_hint
        check_input_data
        user_code_to_a(@user_code)    
        @output.clear
        check_user_code
        if  @win == 1
          puts 'You win!'
          score(@user_name, @attemps_count)
          hash_to_s(@score)
          saves_score(@user_name, @attemps_count, @secret_code)
          break
        end
        unless @output.empty?
          print @output
          puts ''
        end
        @attemps_count += 1
      end
      check_for_lose
      puts "Do you want to play again ?(y/n)"
      again = gets.chomp
      game if again == 'y'
    end

    def new_game
      @secret_code.clear
      @user_code_array.clear
      @user_name = ''
      @user_code = ''
      @check_hint = 0
      @attemps_count = 0
      generate_code
    end

    def generate_code
      4.times { |i| @secret_code[i] = rand(1..6) }
      @secret_code
    end
    
    def check_hint 
      if @check_hint == 0
        puts "Enter code or 'hint':"          
        @user_code = gets.chomp
      elsif @check_hint == 1
        puts "Enter code:"          
        @user_code = gets.chomp
      end
    end

    def output_hint
      if @user_code == "hint"  
        hint
        puts "Enter code:"          
        @user_code = gets.chomp
        @check_hint = 1
      end
    end

    def check_input_data
      unless @user_code =~ /^[1-6]{4}$/
        puts "incorrect data"
        return
      end
    end

    def user_code_to_a arg
      @user_code_array = arg.split('').map(&:to_i)       
    end

    def check_user_code
      if  @user_code_array.eql?(@secret_code) 
        @win = 1
        return
      end
      4.times do |i|
        if  @secret_code[i] == @user_code_array[i]
          @output << '+' unless @output.include?('+')
        elsif  @secret_code.include?(@user_code_array[i])
          @output << '-' unless @output.include?('-')
        end
      end
    end

    def check_for_lose
      if @attemps_count == @attemps
        puts "You lose! Secret code - "
        puts arr_to_s(@secret_code)
      end
    end
    
    def arr_to_s arg
      puts "#{arg[0]} #{arg[1]} #{arg[2]} #{arg[3]}"
    end

    def hash_to_s arg
      puts "#{arg.keys[0]}: #{arg.values[0]} attemps"
    end

    def hint
      hint_array = ['*', '*', '*', '*']
      random = rand(0..3)
      hint_array[random] = secret_code[random]
    end

    def score key, val
      @score[key] = val+1
    end

    def saves_score name, attemps, code
      File.open("score.txt", "a+") do |file| 
        file.write ("Victory:#{name} with attemps - #{attemps}, code - #{code}")
      end
    end
  end


# game = Game.new
# game.game
end