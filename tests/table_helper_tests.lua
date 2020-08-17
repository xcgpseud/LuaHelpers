th = require("helpers.table_helper")
lu = require("luaunit")

TestTableHelper = {}

function TestTableHelper:setUp()
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
    local result = th:make({1, 2, 3}):get()

    lu.assertEquals(result, {1, 2, 3})
end

function TestTableHelper:testRange()
    local withoutStep = th:range(1, 5):get()
    local withStep = th:range(1, 5, 2):get()

    lu.assertEquals(withoutStep, {1, 2, 3, 4, 5})
    lu.assertEquals(withStep, {1, 3, 5})
end

function TestTableHelper:testMap()
    local result = th:make({1, 2, 3, 4, 5}):map(self.x2):get()

    lu.assertEquals(result, {2, 4, 6, 8, 10})
end

function TestTableHelper:testFilter()
    local result = th:make({1, 2, 3, 4, 5}):filter(self.checkEven):get()

    lu.assertEquals(result, {2, 4})
end

function TestTableHelper:testAll()
    local pass = th:make({2, 4, 6}):all(self.checkEven)
    local fail = th:make({2, 4, 5}):all(self.checkEven)

    lu.assertEquals(pass, true)
    lu.assertEquals(fail, false)
end

function TestTableHelper:testAny()
    local pass = th:make({3, 4, 5}):any(self.checkEven)
    local fail = th:make({3, 5, 7}):any(self.checkEven)

    lu.assertEquals(pass, true)
    lu.assertEquals(fail, false)
end

function TestTableHelper:testBreak_()
    local left, right = th:make({1, 3, 4, 5, 7}):break_(self.checkEven)

    lu.assertEquals(left:get(), {1, 3})
    lu.assertEquals(right:get(), {4, 5, 7})
end

function TestTableHelper:testDelete()
    local result = th:make({1, 2, 3, 2, 1}):delete(2):get()

    lu.assertEquals(result, {1, 3, 2, 1})
end

function TestTableHelper:testDrop()
    local result = th:make({1, 2, 3, 4, 5}):drop(2):get()

    lu.assertEquals(result, {3, 4, 5})
end

function TestTableHelper:testImplode()
    local result = th:make({1, 2, 3}):implode(", ")

    lu.assertEquals(result, "1, 2, 3")
end

function TestTableHelper:testDropWhile()
    local result = th:make({2, 4, 5, 4, 2}):dropWhile(self.checkEven):get()

    lu.assertEquals(result, {5, 4, 2})
end

function TestTableHelper:testSum()
    local result = th:make({1, 2, 3, 4, 5}):sum()

    lu.assertEquals(result, 15)
end

os.exit(lu.LuaUnit.run())
