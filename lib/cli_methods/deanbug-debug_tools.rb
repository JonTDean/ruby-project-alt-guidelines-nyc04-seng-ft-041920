class Deanbug

    # Boots to Deanbug Menus
    def self.boot
        self.main_menu                                    # Welcome menu, displays available choices
    end

    private 
    # Displays Main Menu Controller
    def self.main_menu
       choice = CLI.prompts.select("What Menu Would you like to go to?", DeanbugData.main_menu_choices) # Displays interactables, and allows choice input
       DeanbugData.main_menu_logic(choice)
    end

    # Displays Log Menu Controller
    def self.log_menu
        CLI.prompts.say("Welcome to the Debug-Log Menu.")
        
        #Begins Log Menu Prompt
        CLI.prompts.say("Current Debug-Log State: #{DeanbugData.debug_log_state}", color: :blue) # Shows the Current Debug State
        message = "Which task do you want to perform?"

        input = CLI.prompts.select(message, DeanbugData.log_menu_choices ) 
        
        # Performs logic for the table
        DeanbugData.log_menu_logic(input)
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

class DeanbugData < ActiveRecord::Base

    @@log_menu_choices = ["Debug Log On", "Debug Log Off", "Debug Main Menu", "Back to Start Menu", "Exit Program"]
    @@main_menu_choices = [ "Back to Start Menu", "Debug Log Menu"]
    @@debug_log_state = false;"off"
    @old_logger = ActiveRecord::Base.logger

    def self.debug_log_state
        @@debug_log_state
    end

    # Display main_menu_choices elements
    def self.main_menu_choices
        @@main_menu_choices
    end

    # Handles list of allowable Debug Menu choices
    def self.main_menu_logic(choice)
        case choice
        when "Back to Start Menu"
            CLI.prompts.say("Going to Main Menu...")
            puts "Heading back to Log Main Menu..."       
            CLIController.start_screen
        when "Debug Log Menu"
            CLI.prompts.say("Going to Debug-Log Menu...")
            Deanbug.log_menu
        end
    end

    # Display log_menu_choices elements
    def self.log_menu_choices
        @@log_menu_choices
    end
    
    # Handles list of Debug-Log Menu choices
    def self.log_menu_logic(choice)
        case choice
        when "Debug Log On"
            CLI.prompts.say("DEANBUG-LOG: #{self.debug_log_state}", color: :blue) 
            ActiveRecord::Base.logger = @old_logger
            @@debug_log_state = true;"On"
            CLI.prompts.say("Heading back to Log Main Menu...", color: :yellow)   
            Deanbug.log_menu 
        when "Debug Log Off"
            CLI.prompts.say("DEANBUG-LOG: #{self.debug_log_state}", color: :red)
            ActiveRecord::Base.logger = nil
            @@debug_log_state = false;"Off"
            CLI.prompts.say("Heading back to Log Main Menu...", color: :yellow)      
            Deanbug.log_menu                                
        when "Debug Main Menu"
            CLI.prompts.say("Heading to Debug Main Menu", color: :yellow)
            Deanbug.boot
        when "Back to Start Menu"
            CLI.prompts.say("Heading to Start Menu", color: :yellow)
            CLIController.start_screen
        when "Exit Program"
            CLI.prompts.say("Exiting Program... Goodbye!", color: :yellow)
            CLI.close
        end
    end
end