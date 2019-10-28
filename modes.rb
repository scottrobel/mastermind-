require './mastermind_toolbox.rb'
module Modes
    class CodeMakerMode
        def initialize(digits,range)
            new_game(digits,range)
        end    
        def new_game(digits,range)
            green_numbers = {}
            white_numbers = {}
            red_numbers = {}
            possible_digits_for_each_index = []
            digits.times do
                possible_digits_for_each_index.push((1 ..range).to_a)
            end     
            indexes_of_unknown_digits = (0..digits).to_a
            red_numbers
            MasterMindToolBox::print_like_its_typed("welcome to Code Maker mode. In this game You will make the code and the computer will try and guess it")
            secret_code = MasterMindToolBox::get_code_from_user(digits, range)
            MasterMindToolBox::print_like_its_typed("Hmmmmm.....")
            MasterMindToolBox::print_like_its_typed("let me think")
            sleep(2)
            1000.times do
                computer_guess = possible_digits_for_each_index.map{|possible_digit_array| possible_digit_array.sample}
                green_numbers.each do |key,value|
                     computer_guess[key] = value
                     indexes_of_unknown_digits - [key]
                     possible_digits_for_each_index[key] = [value]
                end  
                hints = MasterMindToolBox::get_hints(computer_guess, secret_code)
                hints.each_with_index do |hint,index|
                    case hint
                    when "G"
                        green_numbers[index] = computer_guess[index]
                    when "W"
                        white_numbers[index] = computer_guess[index]
                    when "R"
                        red_numbers[index] = computer_guess[index]
                    else 
                    print "invalid hint"
                    end 
                end
                red_numbers.each do |key,value|
                    possible_digits_for_each_index[key] = possible_digits_for_each_index[key] - [value]
                end 
                white_numbers.each do |key,value|
                    possible_digits_for_each_index[key] = possible_digits_for_each_index[key] - [value]
                end
                MasterMindToolBox::puts_hints(computer_guess, hints)
                if(hints.join("") == "G" * digits)
                    print "I WIN".green + "\n"
                    break
                end 
                sleep(2)
            end
        end 
    end
    class CodeBreakerMode
        def initialize(digits,range)
            code_guesser_mode(digits, range)
        end 
        def code_guesser_mode(digits, range, rounds=10)
            secret_code = MasterMindToolBox::create_code(digits, range)
            hints_array = []
            win = false
            rounds.times do
                user_guess = MasterMindToolBox::get_code_from_user(digits, range)
                hints_array = MasterMindToolBox::get_hints(user_guess ,secret_code)
                MasterMindToolBox::puts_hints(user_guess, hints_array)
                if(hints_array.join() == "G" * digits)
                    puts "congrads you won"
                    break
                end   
            end
            puts "Better luck next time ):" 
        end 
        def prompt_user
            MasterMindToolBox::print_like_its_typed("Hello this is mastermind You have to guess a 4 digit automaticly generated code.")
            MasterMindToolBox::print_like_its_typed("Green number = Right placment and number")
            MasterMindToolBox::print_like_its_typed("white number = right number wrong placement")
            MasterMindToolBox::print_like_its_typed("White Number = wrong number")
        end 
    end 
end 