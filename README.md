# Un Named Project V0.1.0 By Elisheva and Jonny

## 0.1.1 --- Hotfix 0.1.1 | Relationships in Tables

#### Summary -
Our first release consists of table creation and getting the barebones setup, ActiveRecord is connected and all of our gems are properly setup. The next goal is to hit mvp functionality without design work for release 0.2.0 .

**Hotfix Edit**: I added relationships to the tables, in order to finish the barebones process. Overloading them to see if we can take advantage of the functionality added by them. If the relationships aren't being used then they can get stripped away.

### What's New

Jon:

1. Added 5 tables with their migration files.

    * The first table orders(Join Table)
        1. \<Integer :: recipe_id>
        2. \<Integer :: ingredient_id>
        3. \<Integer :: unit_id>
        4. \<Float :: amount>

    * Second is users
        1. \<String :: name>
        2. \<String :: password>

    * Third is recipes
        1. \<Integer :: user_id>
        2. \<String :: title>
        3. \<String :: category>

    * Fourth is ingredients
        1. \<String :: name>

    * Fifth is units
        1. \<String :: name>

2. Hotfix: Relationships

    I added the following relationships to the current tables

    * Order:
        1. belongs to \<recipes> relationship
        2. belongs to \<ingredients> relationship
        3. belongs to \<units> relationship
        4. has one \<user> through \<recipes> relationship.

    * User:
        1. Has many \<recipes>
        2. Has many \<orders> through \<recipes> relationship

    * Recipe:
        1. has many \<orders> relationship
        2. belongs to \<users> relationship

    * Ingredient:
        1. has many \<orders> relationship

    * Units:
        1. has many \<orders> relationship


NEW :::
- Fixed Vendor List, and other gem stuff.