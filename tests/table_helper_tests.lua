require("helpers.table_helper")
lu = require("luaunit")

TestTableHelper = {}

function TestTableHelper:setUp()
    self.make = function(table)
        return TableHelper:new():with(table)
    end

    self.checkEven = function(i)
        return i % 2 == 0
    end

    self.x2 = function(i, x)
        return i * 2
    end
end

function TestTableHelper:tearDown()
end

function TestTableHelper:testGet()
    local result = self.make({1, 2, 3}):get()

    lu.assertEquals(result, {1, 2, 3})
end

function TestTableHelper:testRange()
    local withoutStep = TableHelper:new():range(1, 5):get()
    local withStep = TableHelper:new():range(1, 5, 2):get()

    lu.assertEquals(withoutStep, {1, 2, 3, 4, 5})
    lu.assertEquals(withStep, {1, 3, 5})
end

function TestTableHelper:testMap()
    local result = self.make({1, 2, 3, 4, 5}):map(self.x2):get()

    lu.assertEquals(result, {2, 4, 6, 8, 10})
end

function TestTableHelper:testFilter()
    local result = self.make({1, 2, 3, 4, 5}):filter(self.checkEven):get()

    lu.assertEquals(result, {2, 4})
end

function TestTableHelper:testAll()
    local pass = self.make({2, 4, 6}):all(self.checkEven)
    local fail = self.make({2, 4, 5}):all(self.checkEven)

    lu.assertEquals(pass, true)
    lu.assertEquals(fail, false)
end

function TestTableHelper:testAny()
    local pass = self.make({3, 4, 5}):any(self.checkEven)
    local fail = self.make({3, 5, 7}):any(self.checkEven)

    lu.assertEquals(pass, true)
    lu.assertEquals(fail, false)
end

function TestTableHelper:testBreak_()
    local left, right = self.make({1, 3, 4, 5, 7}):break_(self.checkEven)

    lu.assertEquals(left, {1, 3})
    lu.assertEquals(right, {4, 5, 7})
end

function TestTableHelper:testImplode()
    local result = self.make({1, 2, 3}):implode(", ")

    lu.assertEquals(result, "1, 2, 3")
end

os.exit(lu.LuaUnit.run())
