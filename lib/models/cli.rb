require 'rainbow'

# Main Methods and Important CLI Calls :: OVERHEAD HANDLER FOR TTY 
class CLI
    @@prompt = TTY::Prompt.new
    @@reader = TTY::Reader.new
    @@table = nil

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

    # Table
    ## Data Tables
    def self.pretty_view_table(title, name, ingredients, directions)
        # Top of the List
        meta_list = TTY::Table.new [{"Recipe Name: " => [title, name], "Created By: " => [""]}]
        meta_renderer = TTY::Table::Renderer::Unicode.new(meta_list, multiline: true)
        puts meta_renderer.render

        # Last of the list
        direction_list = TTY::Table.new [{"The Directions Say..." => [directions]}]
        direction_renderer = TTY::Table::Renderer::Unicode.new(direction_list, multiline: true)
        puts direction_renderer.render
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
        logo = [
            '   ____   __   __ _  __  __ _   ___    ____  ____  ___  __  ____  ____    ____  __  __ _  ____  ____  ____  ',
            '  (  _ \ / _\ (  / )(  )(  ( \ / __)  (  _ \(  __)/ __)(  )(  _ \(  __)  (  __)(  )(  ( \(    \(  __)(  _ \ ',
            '   ) _ (/    \ )  (  )( /    /( (_ \   )   / ) _)( (__  )(  ) __/ ) _)    ) _)  )( /    / ) D ( ) _)  )   / ',
            '  (____/\_/\_/(__\_)(__)\_)__) \___/  (__\_)(____)\___)(__)(__)  (____)  (__)  (__)\_)__)(____/(____)(__\_) '
        ]
        
        f_logo = logo.map{|line|
            CLIStyle.cake(line)
        }

        puts ""
        puts f_logo
        puts "" 
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

class CLIStyle
    @@pastel = Pastel.new
    @@pastel.alias_color(:menu, :red, :underline)
    @@colors = Range.new(2,10).to_a
    @@rainbow = Rainbow.new

    # Must pass a string, and then the given paint properties located at : https://github.com/janlelis/paint
    def self.colors(string, x_color)
        
        @@rainbow.wrap(string).color(x_color)
    end

    # Rainbow colored, pass in a string
    def self.rainbow(string)
        colors = Range.new(0,7).to_a
        string.chars.map { |char| Rainbow(char).color(colors.sample) }.join()
    end

    # Cake Look
    def self.cake(string)
        colors = ["#EDFFEC", "#C69DD2", "#7ac74f", "#06d6a0", "#e4b363", "#ff3366", "#5d2e8c", "#c0c999", "#DD5E98", "#e8d7f1"]
        string.chars.map { |char| Rainbow(char).color(colors.sample) }.join
    end

    def self.colorz
        @@colors.sample
    end

end

=begin
##### COLORS USED #####
https://coolors.co/e4b363-ff3366-5d2e8c-06d6a0-26547c-77d7c9-e8d7f1-dd5e98-da50a0-f18805

#Blues-
MEDIUM_SLATE_BLUE: "#7f7eff"
MANATEE: "#9B9FB5"
HONEYDEW: "#EDFFEC"
BLUE_SAPPHIRE: "#166088"
B'dazzled_Blue: "#26547c"

# Purples-
WISTERIA: "#C69DD2"
REBECCA_PURPLE: "#5d2e8c"
PALE_PURPLE: "#e8d7f1"

# Reds-
MAROON: "#b8336a"
RADICAL_RED: "#ff3366"
FANDINGO_PINK: "#DD5E98"
VIVID_BURGUNDY: "#a4243b"

# Yellows-
SUNRAY: "#e4b363"

#Greens-
CARRIBEAN_GREEN: "#06d6a0"
MANTIS: "#7ac74f"
SAGE: "#c0c999"
=end