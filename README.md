# Lua Inventory Management System
A simple inventory management system implemented in Lua, allowing users to search, list, edit, and add items to an inventory.

# Prerequisites
Lua interpreter installed (Lua)
How to Use
Open a terminal or command prompt.

Run the script using the Lua interpreter:

# bash
lua main.lua
Follow the on-screen instructions to interact with the inventory.

# Features
Search: Search for items in the inventory by entering a search term.
List: View a list of all items in the inventory.
Edit: Edit the quantity or price of an existing item.
Add: Add a new item to the inventory.

# Files
main.lua: The main Lua script containing the inventory management logic.
functions.lua: The Lua module providing functions for rendering, searching, listing, editing, and adding items.

# Functions
render_home(): Renders the main menu for inventory management.
print_header(): Prints the header with the application name and current time.
current_time(): Formats the current time and date.
search(): Handles user searches for items in the inventory.
count_occurrences(): Counts occurrences of a value in a table.
find_item_position(): Finds the position of an item in a list.
list(): Displays a list of all items in the inventory.
edit(): Handles editing existing items in the inventory.
add(): Adds a new item to the inventory.

# Author
Evan Grinnell

# License
This project is open-source and free to use, modify, and distribute without any specific license.
