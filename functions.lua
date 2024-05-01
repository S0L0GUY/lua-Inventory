-- 4/30/2024 DEBUGLIBRARY -----------------------
debug = require("DebugLibrary") -- Imports the Debug function Library
debug.clear()
debug.log("successfully imported: DebugLibrary.lua")
--------------------------------------------------

-- Creates needed variadables
inventory = {}
inventory_count = {}
prices = {}

-- Reneders the home
function render_home()
  debug.log("render_home() called")
  debug.log("rendered home")
  print_hedder()
  wait(0.5) --Prints the options
  options = ["Search", "List", "Edit", "Add"]
  print_options(options, 0.1)

  local user_input = io.read()
  local user_input = tonumber(user_input)
  
  if user_input == 1 then -- Prosesses the user input
    search()
  elseif user_input == 2  then
    list()
  elseif user_input == 3 then
    edit()
  elseif user_input == 4 then
    add()
  else
    print_hedder()
    print("Sorry, that is not a valid input.")
    wait(2)
    render_home()
  end
end

-- Prints the hedder
function print_hedder()
  wait("clear")
  print("Lua Inventory" .. "                                                " .. current_time())
  print("-------------------------------------------------------------------------------------")
end

-- Formats the time and date.
function current_time()
  return os.date("%Y-%m-%d %H:%M")
end

-- Handles when the user wants to search
function search()
  debug.log("search() called")
  print_hedder()
  print("Please enter your search term:")
   local user_input = io.read()
  
  print_hedder()

  if count_occurrences(inventory, user_input) < 1 then -- Checks there are search results
    print("Sorry, there are no search results here.")
    wait(2)
    render_home()
  else -- Prints search results
    local item_pos = find_item_position(inventory, user_input)
  print("Your search has returned " .. count_occurrences(inventory, user_input) .. " results")
    wait(0.1)
    print(inventory[item_pos] .. " (" ..                  inventory_count[item_pos] .. ")")
    wait(0.1)
    print("Unit Cost: $" .. prices[item_pos])
    wait(0.1)
    print("Net Cost: $" .. prices[item_pos] * inventory_count[item_pos])
    wait(0.1)
    print("")
    print("Press ENTER to return home.")
    
    local user_input = io.read()
    render_home()
  end
end

-- Counts if the username is in the tables.
function count_occurrences(table, value)
    local count = 0
    for _, v in ipairs(table) do
        if v == value then
            count = count + 1
        end
    end
    return count
end

-- Finds the position of the user/password.
function find_item_position(list, item)
    for i, v in ipairs(list) do
        if v == item then
            return i
        end
    end
    return nil
end

-- Handles when the user wants to list all items
function list()
  debug.log("list() called")
  print_hedder()
  
  if #inventory < 1 then -- Makes shur there items to list
    print_hedder()
    print("Sorry, it seems there are no results.")
  else -- Lists all of the search results
    local count = 1
    print(#inventory .. " results returned:")
    for i = 1, #inventory do
      wait(0.1)
      print(inventory[count] .. " (" .. inventory_count[count] .. ")")
      count = count + 1
    end
  end
  print("Press ENTER to home")
  user_input = io.read()
  render_home()
end

-- Prosesses when the user wants to edit 
function edit()
  debug.log("edit() called")
  print_hedder()
  print("Name of product:")
  user_input = io.read()

  if count_occurrences(inventory, user_input) > 0 then -- Makes shur there is no item already named user_input
    print_hedder()
    print("There are currently " .. inventory_count[find_item_position(inventory, user_input)] .. " of " .. user_input .. ".")
    wait(0.1) -- Prints the current options
    options = ["Remove", "Change Invintory Value", "Change Price"]
    print_options(options, 0.1)
    local itemID = find_item_position(inventory, user_input)
    local item_name = inventory[itemID]
    local user_input = io.read()
    local user_input = tonumber(user_input)

    -- Checks user input
    if user_input == 1 then
      wait("clear")
      print_hedder()
      table.remove(inventory, itemID)
      table.remove(inventory_count, itemID)
      table.remove(prices, itemID)
      print(item_name .. " has been sucsessfully removed")
      wait(2)
      render_home()
    elseif user_input == 2 then
      wait("clear")
      print("What value would you like to change " .. item_name .. " to")
      local user_input = io.read()
      local user_input = tonumber(user_input)
      inventory_count[itemID] = user_input
      wait("clear")
      print_hedder()
      print("The item " .. item_name .. " now has " .. user_input .. " units")
      wait(2)
      render_home()
    elseif user_input == 3 then
      wait("clear")
      print("What price would you like to change " .. item_name .. " to")
      local user_input = io.read()
      local user_input = tonumber(user_input)
      prices[itemID] = user_input
      wait("clear")
      print_hedder()
      print("The item " .. item_name .. " is now $" .. user_input)
      wait(2)
      render_home()
    else
      print_hedder()
      print("Sorry, that is not a valid input.")
      wait(2)
      render_home()
    end
    
  else -- Prints if the input is not valid
    print_hedder()
    print("Sorry, that is not a valid input.")
    wait(2)
    render_home()
  end
end

-- Makes a new item
function add()
  debug.log("add() called")
  print_hedder()
  print("What is the item name:")
  local user_input = io.read()
  local item_name = user_input
  if count_occurrences(inventory, item_name) > 0 then -- Makes shur there is no items already named user_input
    wait("clear")
    print_hedder()
    print("Sorry, there is alredy one of those")
    wait(2)
    render_home()
  else -- Prints if there is not already an item named user_input
    table.insert(inventory, user_input)
    print_hedder()
    print("How many of this product do you have:")
    local user_input = io.read()
    table.insert(inventory_count, user_input)
    print_hedder()
    print("What is the price of the product?")
    local user_input = io.read()
    table.insert(prices, user_input)
    print_hedder()
    print(item_name .. " is now added to the list")
    wait(2)
    render_home()
  end
end

function print_options(options, wait_time)
  if type(options) == "table" then
    for i = 1, #options do
      print(tostring(i) .. ". " .. options[i])
      wait(tonumber(wait_time))
    end
    debug.log("printed options")
  else
    debug.log("")
    return "not a valad variadable type"
  end
end

function wait(seconds)
  local start = os.time()
  repeat until os.time() > start + seconds
end