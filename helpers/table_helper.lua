TableHelper = {
    arr = {}
}

-- Construct.
function TableHelper:new(o) -- TableHelper
    o = o or {}

    setmetatable(o, self)
    self.__index = self

    return o
end

-- Set the inner table.
function TableHelper:with(arr) -- TableHelper
    self.arr = arr
    return self
end

-- Get the inner table.
function TableHelper:get() -- table
    return self.arr
end

-- Map applies the function to each value of the inner table and returns a new TableHelper with the new values.
function TableHelper:map(fn) -- TableHelper
    out = {}

    for _, v in ipairs(self.arr) do
        table.insert(out, fn(v))
    end

    return self:with(out)
end

-- Filter returns a new TableHelper with all of the values in the inner table which pass the given predicate.
function TableHelper:filter(fn) -- TableHelper
    out = {}

    for _, v in ipairs(self.arr) do
        if fn(v) then
            table.insert(out, v)
        end
    end

    return self:with(out)
end

-- Range returns a new TableHelper with the inner table set to a range from first to last, skipping whatever is provided in the step value.
function TableHelper:range(first, last, step) -- TableHelper
    step = step or 1
    out = {}

    for i = first, last, step do
        table.insert(out, i)
    end

    return self:with(out)
end

-- All returns true if all of the elements in the inner table pass the predicate; else it returns false.
function TableHelper:all(fn) -- bool
    for _, v in pairs(self.arr) do
        if not fn(v) then
            return false
        end
    end

    return true
end

-- Any returns true if any of the elements in the inner table pass the predicate; else it returns false.
function TableHelper:any(fn) -- bool
    for _, v in pairs(self.arr) do
        if fn(v) then
            return true
        end
    end

    return false
end

-- Break returns all elements until the predicate passes, followed by the first matching element and the remaining ones.
function TableHelper:break_(fn) -- TableHelper, TableHelper
    local left, right, broken = {}, {}, false

    for _, v in ipairs(self.arr) do
        if broken or fn(v) then
            table.insert(right, v)
            broken = true
        else
            table.insert(left, v)
        end
    end

    return self:new():with(left), self:new():with(right)
end

-- Delete returns all of the elements except for the first occurence of the given element.
function TableHelper:delete(x) -- TableHelper
    local out, deleted = {}, false

    for _, v in ipairs(self.arr) do
        if deleted or v ~= x then
            table.insert(out, v)
        else
            deleted = true
        end
    end

    return self:new():with(out)
end

-- Drop returns all of the elements without the first n elements.
function TableHelper:drop(n) -- TableHelper
    if n >= #self.arr then
        return self:new():with({})
    end

    -- Doing it with an incrementing count variable rather than accessing the numerical index in case of dictionary table
    local out, i = {}, 1
    for _, v in ipairs(self.arr) do
        if i > n then
            table.insert(out, v)
        end

        i = i + 1
    end

    return self:new():with(out)
end

-- Drop elements from the table while the given predicate remains true.
function TableHelper:dropWhile(fn) -- TableHelper
    local out, failed = {}, false

    for _, v in ipairs(self.arr) do
        if failed then
            table.insert(out, v)
        elseif not fn(v) then
            table.insert(out, v)
            failed = true
        end
    end

    return self:new():with(out)
end

-- Implode creates a string, separated by the given character, containing all of the values in the inner table.
function TableHelper:implode(char) -- string
    return table.concat(self.arr, char)
end
