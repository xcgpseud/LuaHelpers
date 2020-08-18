th = require("helpers.table_helper")
lu = require("luaunit")

funcs = {
    checkEven = function(i)
        return i % 2 == 0
    end,
    x2 = function(i)
        return i * 2
    end,
    upper = function(x)
        return string.upper(x)
    end,
    checkUpper = function(x)
        return string.upper(x) == x
    end
}

TestTableHelper = {
    tests = {
        get = {{
            input = {1, 2, 3},
            output = {1, 2, 3}
        }, {
            input = {"hello", "world"},
            output = {"hello", "world"}
        }, {
            input = {},
            output = {}
        }},
        range = {{
            input = {1, 5},
            output = {1, 2, 3, 4, 5}
        }, {
            input = {1, 5, 2},
            output = {1, 3, 5}
        }},
        map = {{
            input = {1, 2, 3},
            fn = funcs.x2,
            output = {2, 4, 6}
        }, {
            input = {"hello", "world"},
            fn = funcs.upper,
            output = {"HELLO", "WORLD"}
        }},
        filter = {{
            input = {1, 2, 3, 4, 5},
            fn = funcs.checkEven,
            output = {2, 4}
        }, {
            input = {"HELLO", "world", "WHAT'S UP?"},
            fn = funcs.checkUpper,
            output = {"HELLO", "WHAT'S UP?"}
        }},
        all = {{
            input = {2, 4, 6},
            fn = funcs.checkEven,
            output = true
        }, {
            input = {2, 4, 5},
            fn = funcs.checkEven,
            output = false
        }, {
            input = {"HELLO", "WHAT'S UP?"},
            fn = funcs.checkUpper,
            output = true
        }, {
            input = {"HELLO", "what is up?"},
            fn = funcs.checkUpper,
            output = false
        }},
        any = {{
            input = {1, 2, 3},
            fn = funcs.checkEven,
            output = true
        }, {
            input = {1, 3, 5},
            fn = funcs.checkEven,
            output = false
        }, {
            input = {"hello", "WHAT'S UP?"},
            fn = funcs.checkUpper,
            output = true
        }, {
            input = {"hello", "what'S Up?"},
            fn = funcs.checkUpper,
            output = false
        }},
        break_ = {{
            input = {1, 3, 4, 5, 7},
            fn = funcs.checkEven,
            left = {1, 3},
            right = {4, 5, 7}
        }, {
            input = {"hello", "world", "WHAT", "is", "UP?"},
            fn = funcs.checkUpper,
            left = {"hello", "world"},
            right = {"WHAT", "is", "UP?"}
        }},
        delete = {{
            input = {1, 2, 3, 2, 1},
            del = 2,
            output = {1, 3, 2, 1}
        }, {
            input = {1, 2, 3},
            del = 4,
            output = {1, 2, 3}
        }, {
            input = {"hello", "world", "hello"},
            del = "hello",
            output = {"world", "hello"}
        }},
        drop = {{
            input = {1, 2, 3, 4, 5},
            drop = 2,
            output = {3, 4, 5}
        }, {
            input = {"hello", "world", "what", "is", "up?"},
            drop = 3,
            output = {"is", "up?"}
        }},
        dropWhile = {{
            input = {2, 4, 5, 6, 7},
            fn = funcs.checkEven,
            output = {5, 6, 7}
        }, {
            input = {"HELLO", "WORLD", "is it", "me you're", "looking for?"},
            fn = funcs.checkUpper,
            output = {"is it", "me you're", "looking for?"}
        }},
        elem = {{
            input = {1, 2, 3},
            elem = 2,
            output = true
        }, {
            input = {1, 2, 3},
            elem = 4,
            output = false
        }, {
            input = {"hello", "world"},
            elem = "hello",
            output = true
        }, {
            input = {"hello", "world"},
            elem = "is it me you're looking for?",
            output = false
        }},
        implode = {{
            input = {1, 2, 3},
            separator = " - ",
            output = "1 - 2 - 3"
        }, {
            input = {"hello", "world"},
            separator = "][",
            output = "hello][world"
        }},
        sum = {{
            input = {1, 2, 3},
            output = 6
        }, {
            input = {},
            output = 0
        }}
    }
}

function TestTableHelper:testGet()
    for _, v in pairs(self.tests.get) do
        local result = th:make(v.input):get()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testRange()
    for _, v in pairs(self.tests.range) do
        local result = th:range(table.unpack(v.input)):get()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testMap()
    for _, v in pairs(self.tests.map) do
        local result = th:make(v.input):map(v.fn):get()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testFilter()
    for _, v in pairs(self.tests.filter) do
        local result = th:make(v.input):filter(v.fn):get()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testAll()
    for _, v in pairs(self.tests.all) do
        local result = th:make(v.input):all(v.fn)

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testAny()
    for _, v in pairs(self.tests.any) do
        local result = th:make(v.input):any(v.fn)

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testBreak_()
    for _, v in pairs(self.tests.break_) do
        local left, right = th:make(v.input):break_(v.fn)

        lu.assertEquals(left:get(), v.left)
        lu.assertEquals(right:get(), v.right)
    end
end

function TestTableHelper:testDelete()
    for _, v in pairs(self.tests.delete) do
        local result = th:make(v.input):delete(v.del):get()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testDrop()
    for _, v in pairs(self.tests.drop) do
        local result = th:make(v.input):drop(v.drop):get()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testDropWhile()
    for _, v in pairs(self.tests.dropWhile) do
        local result = th:make(v.input):dropWhile(v.fn):get()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testElem()
    for _, v in pairs(self.tests.elem) do
        local result = th:make(v.input):elem(v.elem)

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testImplode()
    for _, v in pairs(self.tests.implode) do
        local result = th:make(v.input):implode(v.separator)

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testSum()
    for _, v in pairs(self.tests.sum) do
        local result = th:make(v.input):sum()

        lu.assertEquals(result, v.output)
    end
end

os.exit(lu.LuaUnit.run())
