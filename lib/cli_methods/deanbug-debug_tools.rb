class Deanbug

    attr_accessor :menu_choices                           # Handles list of allowable choices
    private :menu_choices, :menu_choices=

    def self.boot
        self.main_menu                                    # Welcome menu, displays available choices
        self.menu_interaction                             # Displays interactables, and allows choice input
    end

    private 
    # Displays Menu Logic
    def self.main_menu
        @main_menu_choices = ["l"]
        # Container for debug menu
        debug_menu_display = ["Welcome to the Debug Menu.", "Please, Input a command"] 
        debug_menu_display.each{|e| puts e}               # Display menu

        # Choices for Debug Settings
        command_display = ["l - Displays Debug Log Menu"]                              
        command_display.each{|e| puts " - #{e}"}          # Displays Choices
    end

    # Performs Menu Logic
    def self.menu_interaction
        puts "What Menu Would you like to go to?"

        input = STDIN.getch.downcase                      # Grabs user input
        puts "Got Input"
        if self.menu_check(input)                         # If user Input is correct
            self.log_menu                                 # Calls menu_check with input
        elsif !self.menu_check(input)                     # If user Input is not correct
            self.invalid_menu_response(input)             # Invalid response check until correct
        end
    end

    def self.menu_check(input)
        # Checks if the input is correct
        case input                  
        when @main_menu_choices[0]                        # checks input == "l"
            true
        else
            false                                         # Returns false if no menu choices are correct
        end
    end

    # Forces a correct response from user.
    def self.invalid_menu_response(input)
        while !@main_menu_choices.include?(input)         # Runs comparison check against input
            puts "Please give a valid response."          
            @main_menu_choices.each {|e| puts " - #{e}"}  # Displays Menu Choices available
            input = STDIN.getch.downcase
        end
        self.log_menu
    end

    # Hide Database output from log, still capturable https://stackoverflow.com/questions/7724188/how-can-you-hide-database-output-in-rails-console
    def self.log_menu
        puts "If you want to start debug log please type: yes[y] or no[n], to go back to the previous menu type: back[b], if you want to exit type: Quit[q] "
        input = STDIN.getch.downcase
        case input 
        when /yes|y/                                      # If debug mode is on then display logs
            ActiveRecord::Base.logger.level = 0           # Debug mode On
            puts "Heading to Debug Log Menu..."
            self.log_menu                                 # Heads to Debug Log Menu
        when /no|n/                                       # If debug mode is not on then don't display logs
            ActiveRecord::Base.logger.level = 1           # Debug mode Off
            puts "Heading back to Log Main Menu..."       
            self.log_menu                                 # Heads to Debug Log Menu
        when /quit|q/                                     # Exits out of program
            abort("Exiting Program... Goodbye!")          
        when /back|b/                                     # Heads to Debug Main Menu
            puts "Heading to Debug Main Menu..."            
            self.main_menu  
        when /menu|m/                                     # Heads to Start Menu
            puts "Heading to Main Menu"
            CLIUser.start
        when !(/yes|y|no|n|quit|q|back|b|menu|m/)         # Recursive toggle response
            "Please enter a valid response"
            self.log_menu
        end
    end

end    

class DeanbugMenu # Collection of Custom Debug Menus
    
    # For use in <Class :: CLIUser> 
    def self.who_is?(user_name)
        puts "================================================DEBUG================================================"
        puts ""
        puts ""
        puts ""
        puts "                      THE CURRENT USER THAT IS LOGGED IN IS #{user_name.name}"
        puts ""
        puts ""
        puts ""
        puts "================================================DEBUG================================================"
    end 

    # For use in <Class :: Password>
    def self.correct_settings(username, password)
        puts "================================================DEBUG================================================"
        puts ""
        puts ""
        puts "                                  THE CURRENT USER IS #{username}"
        puts "                                THE CURRENT PASSWORD IS #{password}"
        puts ""
        puts ""
        puts "================================================DEBUG================================================"
    end

    # For use in <Class :: SignIn>
    def self.user_object_check(object, id, name, password)
        puts "===============DEBUG==============="
        puts ""
        puts "The User Object is: #{object}"
        puts "The ID is: #{id}"
        puts "The name is: #{name}"
        puts "The password is: #{password}"
        puts ""
        puts "===============DEBUG==============="
    end
end

class DeanbugQuick

    def self.fail
        puts false;"FAIL"       # Only the output of the last command that was executed will be displayed to the screen
    end
    
    def self.success
        puts true;"SUCCESS"     # Only the output of the last command that was executed will be displayed to the screen
    end

end