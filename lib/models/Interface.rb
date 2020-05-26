# Interact and get information from user

class Interface
    attr_accessor :prompt
    private :prompt=

    @@y_n = %w(Yes No)
    @@log_in_menu_message = "Loading Log In Menu"

    def initialize 
        @prompt = TTY::Prompt.new
    end

    # Creates Loading Bar
    def self.loading_bar(message)
        bar = TTY::ProgressBar.new("#{message} [:bar]", total: 30)
        10.times do
        sleep(0.1)
        bar.advance(3)
        end
    end
     
    # Displays Yes or No
    def self.y_n
        @@y_n
    end

    def self.back_to_log_in_menu
        puts "Going back to Log In Menu..."
        self.loading_bar(@@log_in_menu_message)
        CLIUser.new
    end
end
