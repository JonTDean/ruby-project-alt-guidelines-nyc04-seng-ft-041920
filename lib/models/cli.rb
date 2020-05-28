# Main Methods and Important CLI Calls :: OVERHEAD HANDLER FOR TTY 
class CLI
    @@prompt = TTY::Prompt.new
    @@reader = TTY::Reader.new

    # Prompt
    ## Allows for use of TTY::Prompt across multiple Classes
    def self.prompts
        @@prompt
    end

    # Reader
    ## Allows for use of TTY::Reader across multiple Classes
    def self.reader
        @@reader
    end

    # Loading Bar
    ## Creates Loading Bar
    def self.loading_bar(message)
        bar = TTY::ProgressBar.new("#{message} [:bar]", total: 30)
        10.times do
            sleep(0.1)
            bar.advance(3)
        end
    end

    #Miscellaneous Function
    ## Brings User Back to Log In Menu
    def self.back_to_log_in_menu
        self.loading_bar("Loading Log In Menu...")
        CLIUserController.new
    end

    ## Exits Program
    def self.close
        self.loading_bar("Exiting Program...")
        abort("Goodbye!")
    end

    def self.logo
        puts "         ________  _______   ________  ___  ________  _______           ________ ___  ________   ________  _______   ________     
        |\\   __  \\|\\  ___ \\ |\\   ____\\|\\  \\|\\   __  \\|\\  ___ \\         |\\  _____\\\\  \\|\\   ___  \\|\\   ___ \\|\\  ___ \\ |\\   __  \\    
        \\ \\  \\|\\  \\ \\   __/|\\ \\  \\___|\\ \\  \\ \\  \\|\\  \\ \\   __/|        \\ \\  \\__/\\ \\  \\ \\  \\\\ \\  \\ \\  \\_|\\ \\ \\   __/|\\ \\  \\|\\  \\   
         \\ \\   _  _\\ \\  \\_|/_\\ \\  \\    \\ \\  \\ \\   ____\\ \\  \\_|/__       \\ \\   __\\\\ \\  \\ \\  \\\\ \\  \\ \\  \\ \\\\ \\ \\  \\_|/_\\ \\   _  _\\  
          \\ \\  \\\\  \\\\ \\  \\_|\\ \\ \\  \\____\\ \\  \\ \\  \\___|\\ \\  \\_|\\ \\       \\ \\  \\_| \\ \\  \\ \\  \\\\ \\  \\ \\  \\_\\\\ \\ \\  \\_|\\ \\ \\  \\\\  \\| 
           \\ \\__\\\\ _\\\\ \\_______\\ \\_______\\ \\__\\ \\__\\    \\ \\_______\\       \\ \\__\\   \\ \\__\\ \\__\\\\ \\__\\ \\_______\\ \\_______\\ \\__\\\\ _\\ 
            \\|__|\\|__|\\|_______|\\|_______|\\|__|\\|__|     \\|_______|        \\|__|    \\|__|\\|__| \\|__|\\|_______|\\|_______|\\|__|\\|__|"
    end

end

# Helper Methods
class CLIHelper
    @@y_n_e = %w(Yes No Quit) # Array for "Yes, No, Quit"


    # Displays Yes, No, Quit
    def self.y_n_e
        @@y_n_e
    end
end