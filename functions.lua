-- creates needed variadables
inventory = {}
inventory_count = {}
prices = {}

-- rneders the home
function render_home()
  print_hedder()
  os.execute("sleep 0.5") --prints the options
  print("1.Search")
  os.execute("sleep 0.1")
  print("2.List")
  os.execute("sleep 0.1")
  print("3.Edit")
  os.execute("sleep 0.1")
  print("4.Add")
  local user_input = io.read()
  local user_input = tonumber(user_input)
  
  if user_input == 1 then -- prosesses the user input
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
    os.execute("sleep 2")
    render_home()
  end
  
end

-- prints the hedder
function print_hedder()
  os.execute("clear")
  print("Lua Inventory" .. "                                                " .. current_time())
  print("-------------------------------------------------------------------------------------")
end

-- Formats the time and date.
function current_time()
  return os.date("%Y-%m-%d %H:%M")
end

-- handles when the user wants to search
function search()
  print_hedder()
  print("Please enter your search term:")
   local user_input = io.read()
  
  print_hedder()

  if count_occurrences(inventory, user_input) < 1 then -- checks there are search results
    print("Sorry, there are no search results here.")
    os.execute("sleep 2")
    render_home()
  else -- prints search results
    local item_pos = find_item_position(inventory, user_input)
  print("Your search has returned " .. count_occurrences(inventory, user_input) .. " results")
    os.execute("sleep 0.1")
    print(inventory[item_pos] .. " (" ..                  inventory_count[item_pos] .. ")")
    os.execute("sleep 0.1")
    print("Unit Cost: $" .. prices[item_pos])
    os.execute("sleep 0.1")
    print("Net Cost: $" .. prices[item_pos] * inventory_count[item_pos])
    os.execute("sleep 0.1")
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

-- handles when the user wants to list all items
function list()
  print_hedder()
  
  if #inventory < 1 then -- makes shur there items to list
    print_hedder()
    print("Sorry, it seems there are no results.")
  else -- lists all of the search results
    local count = 1
    print(#inventory .. " results returned:")
    for i = 1, #inventory do
      os.execute("sleep 0.1")
      print(inventory[count] .. " (" .. inventory_count[count] .. ")")
      count = count + 1
    end
  end
  print("Press ENTER to home")
  user_input = io.read()
  render_home()
end

-- prosesses when the user wants to edit 
function edit()
  print_hedder()
  print("Name of product:")
  user_input = io.read()

  if count_occurrences(inventory, user_input) > 0 then -- makes shur there is no item already named user_input
    print_hedder()
    print("There are currently " .. inventory_count[find_item_position(inventory, user_input)] .. " of " .. user_input .. ".")
    os.execute("sleep 0.1") -- prints the current options
    print("1.Remove")
    os.execute("sleep 0.1")
    print("2.Change Invintory Value")
    os.execute("sleep 0.1")
    print("3.Change Price")
    local itemID = find_item_position(inventory, user_input)
    local item_name = inventory[itemID]
    local user_input = io.read()
    local user_input = tonumber(user_input)

    -- checks user input
    if user_input == 1 then
      os.execute("clear")
      print_hedder()
      table.remove(inventory, itemID)
      table.remove(inventory_count, itemID)
      table.remove(prices, itemID)
      print(item_name .. " has been sucsessfully removed")
      os.execute("sleep 2")
      render_home()
    elseif user_input == 2 then
      os.execute("clear")
      print("What value would you like to change " .. item_name .. " to")
      local user_input = io.read()
      local user_input = tonumber(user_input)
      inventory_count[itemID] = user_input
      os.execute("clear")
      print_hedder()
      print("The item " .. item_name .. " now has " .. user_input .. " units")
      os.execute("sleep 2")
      render_home()
    elseif user_input == 3 then
      os.execute("clear")
      print("What price would you like to change " .. item_name .. " to")
      local user_input = io.read()
      local user_input = tonumber(user_input)
      prices[itemID] = user_input
      os.execute("clear")
      print_hedder()
      print("The item " .. item_name .. " is now $" .. user_input)
      os.execute("sleep 2")
      render_home()
    else
      print_hedder()
      print("Sorry, that is not a valid input.")
      os.execute("sleep 2")
      render_home()
    end
    
  else -- prints if the input is not valid
    print_hedder()
    print("Sorry, that is not a valid input.")
    os.execute("sleep 2")
    render_home()
  end
end

-- makes a new item
function add()
  print_hedder()
  print("What is the item name:")
  local user_input = io.read()
  local item_name = user_input
  if count_occurrences(inventory, item_name) > 0 then -- makes shur there is no items already named user_input
    os.execute("clear")
    print_hedder()
    print("Sorry, there is alredy one of those")
    os.execute("sleep 2")
    render_home()
  else -- prints if there is not already an item named user_input
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
    os.execute("sleep 2")
    render_home()
  end
end

