require("luahelpers")
lu = require("luaunit")

TestLuaHelpers = {}

function TestLuaHelpers:setUp()
    self.make = function(table)
        return LuaHelpers:new():with(table)
    end

    self.checkEven = function(i)
        return i % 2 == 0
    end

    self.x2 = function(i, x)
        return i * 2
    end
end

function TestLuaHelpers:tearDown()
end

function TestLuaHelpers:testGet()
    local result = self.make({1, 2, 3}):get()

    lu.assertEquals(result, {1, 2, 3})
end

function TestLuaHelpers:testRange()
    local withoutStep = LuaHelpers:new():range(1, 5):get()
    local withStep = LuaHelpers:new():range(1, 5, 2):get()

    lu.assertEquals(withoutStep, {1, 2, 3, 4, 5})
    lu.assertEquals(withStep, {1, 3, 5})
end

function TestLuaHelpers:testMap()
    local result = self.make({1, 2, 3, 4, 5}):map(self.x2):get()

    lu.assertEquals(result, {2, 4, 6, 8, 10})
end

function TestLuaHelpers:testFilter()
    local result = self.make({1, 2, 3, 4, 5}):filter(self.checkEven):get()

    lu.assertEquals(result, {2, 4})
end

function TestLuaHelpers:testAll()
    local pass = self.make({2, 4, 6}):all(self.checkEven)
    local fail = self.make({2, 4, 5}):all(self.checkEven)

    lu.assertEquals(pass, true)
    lu.assertEquals(fail, false)
end

function TestLuaHelpers:testAny()
    local pass = self.make({3, 4, 5}):any(self.checkEven)
    local fail = self.make({3, 5, 7}):any(self.checkEven)

    lu.assertEquals(pass, true)
    lu.assertEquals(fail, false)
end

function TestLuaHelpers:testBreak_()
    local left, right = self.make({1, 3, 4, 5, 7}):break_(self.checkEven)

    lu.assertEquals(left, {1, 3})
    lu.assertEquals(right, {4, 5, 7})
end

function TestLuaHelpers:testImplode()
    local result = self.make({1, 2, 3}):implode(", ")

    lu.assertEquals(result, "1, 2, 3")
end

os.exit(lu.LuaUnit.run())
