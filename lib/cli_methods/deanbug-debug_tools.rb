class Deanbug

    # Boots to Deanbug Menus
    def self.boot
        self.main_menu                                    # Welcome menu, displays available choices
        self.menu_interaction                             # Displays interactables, and allows choice input
    end

    private 
    # Displays Menu Logic
    def self.main_menu
        CLI.prompts.expand("What Menu Would you like to go to?", DeanbugData.main_menu_choices)
    end

    def self.log_menu
        CLI.prompts.say("Welcome to the Debug Menu.")
        
        # Begins Log Menu Prompt
        # input = CLI.prompts.expand( 
        #     "To - Start DebugLog  y, Stop DebugLog  On, Go to Debug Main Menu Off,  Quit program : Quit, Start Screen  Leave", 
        #     DeanbugData.log_menu_choices 
        # ) 
        # DeanbugData.log_menu_logic(input)
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

class DeanbugData
    attr_accessor :log_menu_choices
    @@log_menu_choices = ["On", "Off", "Back", "Quit","Leave"]

    # Handles list of allowable Debug Menu choices
    def self.main_menu_choices
        [ 
            {key: "l", name: "Debug Log Menu", value: Deanbug.log_menu}
        ]
    end

    def self.log_menu_choices
        @@log_menu_choices
    end
    
    # Handles list of Debug-Log Menu choices
    def self.log_menu_logic(choice)
        # # Make a choice Hash?
        # choice_hash = {
        #     On: ActiveRecord::Base.logger.level = 0
        # }
        # Do choice.to_sym
        case choice
        when /On/
            CLI.prompts.say("DEANBUG-LOG: ON")
            ActiveRecord::Base.logger.level = 0
            puts "Heading back to Log Main Menu..."       
            self.log_menu 
        when /Off/
            CLI.prompts.say("DEANBUG-LOG: OFF")
            ActiveRecord::Base.logger.level = 1
            puts "Heading back to Log Main Menu..."       
            self.log_menu                                
        when /Back/
            CLI.prompts.say("Heading to Debug Main Menu")
            Deanbug.boot
        when /Quit/
            CLI.prompts.say("Exiting Program... Goodbye!")
            CLI.close
        when /Leave/
            CLI.prompts.say("Heading to Start Menu")
            CLIUser.start
        end
    end
end