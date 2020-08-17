# LuaHelpers

### Usage:

> Clone / download the repository

> Move the helper files in to your project (whichever desired ones)

> Require the helpers in any files you wish to use them in

### TableHelper Usage Example:

```lua
th = require("helpers.table_helper")

-- Get the sum of all even numbers between 1 and 100
result = th:range(1, 100):filter(function(i)
    return i % 2 == 0
end):sum()

-- If all of the elements in a table are greater than 10...
table = {11, 12, 13}
if th:make(table):all(function(i)
    return i > 10
end) then
    -- do something
end

-- Display all of the names in caps, comma separated
table = {"John Doe", "Jane Doe", "Jim Bob"}
result = th:make(table):map(function(x)
    return string.upper(x)
end):implode(", ")

-- Result: "JOHN DOE, JANE DOE, JIM BOB"
```