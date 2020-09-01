DictionaryHelper = {
    table = {}
}

function DictionaryHelper:_new(o)
    o = o or {}

    setmetatable(o, self)
    self.__index = self

    return o
end

function DictionaryHelper:_with(table)
    self.table = table
    return self
end

function DictionaryHelper:make(table)
    return self:_new():_with(table)
end

function DictionaryHelper:get()
    return self.table
end

function DictionaryHelper:abs()
    local out = {}

    for k, v in pairs(self.table) do
        out[k] = math.abs(v)
    end

    return self:make(out)
end

function DictionaryHelper:all(fn)
    for _, v in pairs(self.table) do
        if not fn(v) then
            return false
        end
    end

    return true
end

function DictionaryHelper:any(fn)
    for _, v in pairs(self.table) do
        if fn(v) then
            return true
        end
    end

    return false
end

function DictionaryHelper:filter(fn)
    local out = {}

    for k, v in pairs(self.table) do
        if fn(v) then
            out[k] = v
        end
    end

    return self:make(out)
end

function DictionaryHelper:map(fn)
    local out = {}

    for k, v in pairs(self.table) do
        out[k] = fn(v)
    end

    return self:make(out)
end

return DictionaryHelper
