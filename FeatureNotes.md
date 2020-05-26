# User Log In and Auth - Jon

## User Auth

Quick Notes:

* I converted User Auth to use the 'TTY' Gem for the prompts, reduced over 100+ lines of code.

#### Quick TODO

Clear the Database, this way we can work with a new DataSet.

### 1A: Login System

* Login to Account (Account Directly connected to Existing User Tables)

* Create Account (If an account is not found the user is then prompted to create a new one)

* Enter UserPortal (Currently Empty), UserPortal, will be entry point from which the logged_in_user can interact with their Recipes via some view function

* If User Creates a new account, walks through Username and Password Creation

* Username is allowed to be Spaces and Letters (Uppercase and Lower Case)

* If Username is a Number or a Special Character then the user has to retype until Username only contains Letters(Uppercase and Lowercase) or spaces !!!Need to Add case check for more than 1 consecutive space in a row

* Creates new User inside of users Table

### 1B: Password System

* Checks password for Numbers and Letters (Uppercase and Lower Case)

* Forces user to type in a password with only Letters and Numbers

* Stores Password in a Hash \<Salt = default> named BCrypt::Password.new(user_object.password)

* BCrypt::Password.new(user_object.password) is then compared to an input string and returns a boolean

* TRUE: Sets CLIUser class to have an Instance of Variable :current_user (Effectively serving as a makeshift token.) through CLIUser.log_in_to_account(@current_user)

* FALSE: Pushes to UserAccountCreation.ask_user_create?

#### TODO

1. Log Out feature:
 As of now the the only way to "log out" is to cmd(ctrl) + z

2. Delete User:
 No way at all to Delete User

3. Downcase the incoming input of the user for new account creations
--------------------------------------------

## 2: Debug System - Deanbug

* Toggles Return of Variables to Log. So if off , all non implicit STDOUT are not printed.  Puts, Print, p, and pp are accepted (Return Value will not be printed, only STDOUT).

* added modular features, to expand as we make different modules

* In place of UserPortal, DeanbugMenu has a default display module

#### TODO

1. Convert Deanbug prompts to use 'TTY' Gem
