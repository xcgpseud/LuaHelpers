TableHelper = {
    table = {}
}

-- Construct.
function TableHelper:_new(o) -- TableHelper
    o = o or {}

    setmetatable(o, self)
    self.__index = self

    return o
end

-- Set the inner table.
function TableHelper:_with(table) -- TableHelper
    self.table = table
    return self
end

-- Make returns a new instance of this class.
function TableHelper:make(table)
    return self:_new():_with(table)
end

-- Range returns a new TableHelper with the table set to a range from first to last, skipping whatever is provided in the step value.
function TableHelper:range(first, last, step) -- TableHelper
    step = step or 1
    out = {}

    for i = first, last, step do
        table.insert(out, i)
    end

    return self:_new():_with(out)
end

-- Get gets the table.
function TableHelper:get() -- table
    return self.table
end

-- Map applies the function to each value of the table and returns a new TableHelper with the results.
function TableHelper:map(fn) -- TableHelper
    out = {}

    for _, v in ipairs(self.table) do
        table.insert(out, fn(v))
    end

    return self:make(out)
end

-- Filter returns a new TableHelper with all of the values in the table which pass the given predicate.
function TableHelper:filter(fn) -- TableHelper
    out = {}

    for _, v in ipairs(self.table) do
        if fn(v) then
            table.insert(out, v)
        end
    end

    return self:make(out)
end

-- All returns true if all of the elements in the table pass the predicate; else it returns false.
function TableHelper:all(fn) -- bool
    for _, v in pairs(self.table) do
        if not fn(v) then
            return false
        end
    end

    return true
end

-- Any returns true if any of the elements in the table pass the predicate; else it returns false.
function TableHelper:any(fn) -- bool
    for _, v in pairs(self.table) do
        if fn(v) then
            return true
        end
    end

    return false
end

-- Break returns all elements until the predicate passes, followed by the first matching element and the remaining ones.
function TableHelper:break_(fn) -- TableHelper, TableHelper
    local left, right, broken = {}, {}, false

    for _, v in ipairs(self.table) do
        if broken or fn(v) then
            table.insert(right, v)
            broken = true
        else
            table.insert(left, v)
        end
    end

    return self:make(left), self:make(right)
end

-- Delete returns all of the elements except for the first occurence of the given element.
function TableHelper:delete(x) -- TableHelper
    local out, deleted = {}, false

    for _, v in ipairs(self.table) do
        if deleted or v ~= x then
            table.insert(out, v)
        else
            deleted = true
        end
    end

    return self:make(out)
end

-- Drop returns all of the elements without the first n elements.
function TableHelper:drop(n) -- TableHelper
    if n >= #self.table then
        return self:make({})
    end

    local out = {}
    for i = n + 1, #self.table do
        table.insert(out, self.table[i])

        i = i + 1
    end

    return self:make(out)
end

-- Drop drops elements from the table while the given predicate remains true.
function TableHelper:dropWhile(fn) -- TableHelper
    local out, failed = {}, false

    for _, v in ipairs(self.table) do
        if failed then
            table.insert(out, v)
        elseif not fn(v) then
            table.insert(out, v)
            failed = true
        end
    end

    return self:make(out)
end

-- Elem returns true if the table contains the given element; else it returns false.
function TableHelper:elem(x) -- bool
    for _, v in pairs(self.table) do
        if x == v then
            return true
        end
    end

    return false
end

-- Foldl iteratively applies the function from left to right, beginning with the init.
function TableHelper:foldl(init, fn)
    if #self.table == 0 then
        return init
    end

    local out

    for i = 1, #self.table do
        if i == 1 then
            out = fn(init, self.table[i])
        else
            out = fn(out, self.table[i])
        end

        i = i + 1
    end

    return out
end

-- Foldl1 iteratively applies the function from left to right, beginning with the first element.
function TableHelper:foldl1(fn)
    local out = self.table[1]

    for i = 2, #self.table do
        out = fn(out, self.table[i])

        i = i + 1
    end

    return out
end

-- Foldr iteratively applies the function from right to left, beginning with the init.
function TableHelper:foldr(init, fn)
    if #self.table == 0 then
        return init
    end

    local out

    for i = #self.table, 1, -1 do
        if i == #self.table then
            out = fn(init, self.table[i])
        else
            out = fn(out, self.table[i])
        end
    end

    return out
end

-- Foldr1 iteratively applies the function from right to left, beginning with the last element.
function TableHelper:foldr1(fn)
    local out

    for i = #self.table, 1, -1 do
        if i == #self.table then
            out = self.table[i]
        else
            out = fn(out, self.table[i])
        end
    end

    return out
end

-- Implode creates a string, separated by the given character, containing all of the values in the table.
function TableHelper:implode(char) -- string
    return table.concat(self.table, char)
end

-- Sum returns the sum of all elements in the table.
function TableHelper:sum() -- int
    local out = 0

    for _, v in pairs(self.table) do
        out = out + v
    end

    return out
end

return TableHelper
