require './mastermind_toolbox.rb'
module Modes
    class CodeMakerMode
        def initialize(digits,range)
            new_game(digits,range)
        end    
        def new_game(digits,range)
            green_numbers,white_numbers,red_numbers = {},{},{}
            possible_digits_for_each_index = MasterMindToolBox::populate_possible_digits(digits, range)
            MasterMindToolBox::print_like_its_typed("welcome to Code Maker mode. In this game You will make the code and the computer will try and guess it")
            secret_code = MasterMindToolBox::get_code_from_user(digits, range)
            MasterMindToolBox::print_like_its_typed("Hmmmmm.....")
            MasterMindToolBox::print_like_its_typed("let me think")
            sleep(2)
            1000.times do
                computer_guess = MasterMindToolBox::select_randomly_from_possible_digits(possible_digits_for_each_index)
                hints = MasterMindToolBox::get_hints(computer_guess, secret_code)
                green_numbers, white_numbers, red_numbers = MasterMindToolBox::populate_color_hint_hashes(green_numbers,white_numbers,red_numbers,computer_guess,hints)
                possible_digits_for_each_index = MasterMindToolBox::update_possible_digits(green_numbers, white_numbers,red_numbers,possible_digits_for_each_index)
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
            loss = true
            rounds.times do
                user_guess = MasterMindToolBox::get_code_from_user(digits, range)
                hints_array = MasterMindToolBox::get_hints(user_guess ,secret_code)
                MasterMindToolBox::puts_hints(user_guess, hints_array)
                if(hints_array.join() == "G" * digits)
                    puts "congrads you won"
                    loss = false
                    break
                end   
            end
            puts "Better luck next time ):" if(loss)
        end 
        def prompt_user
            MasterMindToolBox::print_like_its_typed("Hello this is mastermind You have to guess a 4 digit automaticly generated code.")
            MasterMindToolBox::print_like_its_typed("Green number = Right placment and number")
            MasterMindToolBox::print_like_its_typed("white number = right number wrong placement")
            MasterMindToolBox::print_like_its_typed("White Number = wrong number")
        end 
    end 
end 