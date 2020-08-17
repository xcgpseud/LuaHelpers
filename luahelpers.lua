LuaHelpers = {
    arr = {}
}

-- Construct.
function LuaHelpers:new(o) -- LuaHelpers
    o = o or {}

    setmetatable(o, self)
    self.__index = self

    return o
end

-- Set the inner table.
function LuaHelpers:with(arr) -- LuaHelpers
    self.arr = arr
    return self
end

-- Get the inner table.
function LuaHelpers:get() -- table
    return self.arr
end

-- Map applies the function to each value of the inner table and returns a new LuaHelpers with the new values.
function LuaHelpers:map(fn) -- LuaHelpers
    out = {}

    for _, v in ipairs(self.arr) do
        table.insert(out, fn(v))
    end

    return self:with(out)
end

-- Filter returns a new LuaHelpers with all of the values in the inner table which pass the given predicate.
function LuaHelpers:filter(fn) -- LuaHelpers
    out = {}

    for _, v in ipairs(self.arr) do
        if fn(v) then
            table.insert(out, v)
        end
    end

    return self:with(out)
end

-- Range returns a new LuaHelpers with the inner table set to a range from first to last, skipping whatever is provided in the step value.
function LuaHelpers:range(first, last, step) -- LuaHelpers
    step = step or 1
    out = {}

    for i = first, last, step do
        table.insert(out, i)
    end

    return self:with(out)
end

-- All returns true if all of the elements in the inner table pass the predicate; else it returns false.
function LuaHelpers:all(fn) -- bool
    for _, v in pairs(self.arr) do
        if not fn(v) then
            return false
        end
    end

    return true
end

-- Any returns true if any of the elements in the inner table pass the predicate; else it returns false.
function LuaHelpers:any(fn) -- bool
    for _, v in pairs(self.arr) do
        if fn(v) then
            return true
        end
    end

    return false
end

-- Break returns all elements until the predicate passes, followed by the first matching element and the remaining ones.
function LuaHelpers:break_(fn) -- table, table
    local left, right, broken = {}, {}, false

    for _, v in ipairs(self.arr) do
        if broken or fn(v) then
            table.insert(right, v)
            broken = true
        else
            table.insert(left, v)
        end
    end

    return left, right
end



-- Implode creates a string, separated by the given character, containing all of the values in the inner table.
function LuaHelpers:implode(char) -- string
    return table.concat(self.arr, char)
end
