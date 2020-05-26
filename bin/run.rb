require_relative '../config/environment'
require_relative '../lib/cli_methods/cli_user'
# cli = CommandLineInterface.new

# cli.start_screen


puts "Start in debug mode? Type Yes[y] or No[n] to start."
input = STDIN.gets.chomp.downcase

# Ask for debug mode, !!!!REMOVE IN DEVELOP!!!!!
def debug_mode(response)
    case response
    when /y|yes/
        puts "Debug Starting..."
        Deanbug.boot
    when /n|no/
        puts "User Login Starting..."
        CLIUser.new
    else
        puts "Type either Yes[y] or No[n] to proceed!"
        input = STDIN.gets.chomp.downcase
        debug_mode(input)
    end
end

debug_mode(input)
