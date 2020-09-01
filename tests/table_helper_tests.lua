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
    end,
    multiply = function(x, y)
        return x * y
    end,
    concatUpper = function(x, y)
        return string.upper(x) .. " " .. string.upper(y)
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
        abs = {{
            input = {2, 4, 6},
            output = {2, 4, 6}
        }, {
            input = {-2, -4, 6},
            output = {2, 4, 6}
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
        average = {{
            input = {1, 2, 3, 4, 5},
            output = 3
        }, {
            input = {},
            output = 0
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
        }},
        foldl = {{
            input = {2, 10},
            init = 5,
            fn = funcs.multiply,
            output = 100 -- 5 * 2 * 10
        }, {
            input = {"hello", "world", "it's", "me"},
            init = "uh...",
            fn = funcs.concatUpper,
            output = "UH... HELLO WORLD IT'S ME"
        }, {
            input = {},
            init = 2,
            fn = funcs.multiply,
            output = 2
        }},
        foldl1 = {{
            input = {2, 2, 10},
            fn = funcs.multiply,
            output = 40 -- 2 * 2 * 10
        }, {
            input = {"hello", "world", "it's", "me"},
            fn = funcs.concatUpper,
            output = "HELLO WORLD IT'S ME"
        }, {
            input = {2},
            fn = funcs.multiply,
            output = 2
        }},
        foldr = {{
            input = {2, 10, 10},
            init = 2,
            fn = funcs.multiply,
            output = 400 -- 2 * 10 * 10 * 2
        }, {
            input = {"hello", "world"},
            init = "hey!",
            fn = funcs.concatUpper,
            output = "HEY! WORLD HELLO"
        }, {
            input = {},
            init = 2,
            fn = funcs.multiply,
            output = 2
        }},
        foldr1 = {{
            input = {2, 10, 20},
            fn = funcs.multiply,
            output = 400 -- 20 * 10 * 2
        }, {
            input = {"hello", "world", "it's me!"},
            fn = funcs.concatUpper,
            output = "IT'S ME! WORLD HELLO"
        }, {
            input = {2},
            fn = funcs.multiply,
            output = 2
        }},
        group = {{
            input = {1, 2, 3},
            output = {{1}, {2}, {3}}
        }, {
            input = {1, 1, 2, 2, 1, 2, 3, 3, 3},
            output = {{1, 1}, {2, 2}, {1}, {2}, {3, 3, 3}}
        }, {
            input = {"hi", "hi", "hello", "hi"},
            output = {{"hi", "hi"}, {"hello"}, {"hi"}}
        }},
        head = {{
            input = {1, 2, 3},
            output = 1
        }, {
            input = {},
            output = nil
        }, {
            input = {"hi", "world"},
            output = "hi"
        }},
        init = {{
            input = {1, 2, 3},
            output = {1, 2}
        }, {
            input = {},
            output = {}
        }, {
            input = {"hi", "world", "it's me"},
            output = {"hi", "world"}
        }},
        inits = {{
            input = {1, 2, 3},
            output = {{}, {1}, {1, 2}, {1, 2, 3}}
        }, {
            input = {},
            output = {}
        }, {
            input = {"hi", "world"},
            output = {{}, {"hi"}, {"hi", "world"}}
        }},
        intercalate = {{
            input = {9, 8},
            tables = {{1, 2}, {3, 4}, {5, 6}},
            output = {1, 2, 9, 8, 3, 4, 9, 8, 5, 6}
        }, {
            input = {},
            tables = {{1, 2}, {3, 4}},
            output = {1, 2, 3, 4}
        }},
        intersperse = {{
            input = {4, 2, 0},
            x = 1337,
            output = {4, 1337, 2, 1337, 0}
        }, {
            input = {1, 2, 3},
            x = {1, 2},
            output = {1, {1, 2}, 2, {1, 2}, 3}
        }},
        isPrefixOf = {{
            input = {1, 2, 3},
            tbl = {1, 2},
            output = false
        }, {
            input = {1, 2},
            tbl = {1, 2, 3},
            output = true
        }, {
            input = {1, 2, 3},
            tbl = {1, 2, 4},
            output = false
        }, {
            input = {},
            tbl = {},
            output = true
        }},
        last = {{
            input = {1, 2, 3},
            output = 3
        }, {
            input = {"hello", "world", "it's", "me"},
            output = "me"
        }},
        length = {{
            input = {1, 2, 3},
            output = 3
        }, {
            input = {},
            output = 0
        }, {
            input = {1},
            output = 1
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

function TestTableHelper:testAbs()
    for _, v in pairs(self.tests.abs) do
        local result = th:make(v.input):abs():get()

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

function TestTableHelper:testAverage()
    for _, v in pairs(self.tests.average) do
        local result = th:make(v.input):average()

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

function TestTableHelper:testFoldl()
    for _, v in pairs(self.tests.foldl) do
        local result = th:make(v.input):foldl(v.init, v.fn)

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testFoldl1()
    for _, v in pairs(self.tests.foldl1) do
        local result = th:make(v.input):foldl1(v.fn)

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testFoldr()
    for _, v in pairs(self.tests.foldr) do
        local result = th:make(v.input):foldr(v.init, v.fn)

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testFoldr1()
    for _, v in pairs(self.tests.foldr1) do
        local result = th:make(v.input):foldr1(v.fn)

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testGroup()
    for _, v in pairs(self.tests.group) do
        local result = th:make(v.input):group():get()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testHead()
    for _, v in pairs(self.tests.head) do
        local result = th:make(v.input):head()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testInit()
    for _, v in pairs(self.tests.init) do
        local result = th:make(v.input):init():get()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testInits()
    for _, v in pairs(self.tests.inits) do
        local inits = th:make(v.input):inits()

        for i, init in ipairs(inits) do
            lu.assertEquals(init, v.output[i])
        end
    end
end

function TestTableHelper:testIntercalate()
    for _, v in pairs(self.tests.intercalate) do
        local result = th:make(v.input):intercalate(v.tables):get()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testIntersperse()
    for _, v in pairs(self.tests.intersperse) do
        local result = th:make(v.input):intersperse(v.x):get()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testIsPrefixOf()
    for _, v in pairs(self.tests.isPrefixOf) do
        local result = th:make(v.input):isPrefixOf(v.tbl)

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testLast()
    for _, v in pairs(self.tests.last) do
        local result = th:make(v.input):last()

        lu.assertEquals(result, v.output)
    end
end

function TestTableHelper:testLength()
    for _, v in pairs(self.tests.length) do
        local result = th:make(v.input):length()

        lu.assertEquals(result, v.output)
    end
end

os.exit(lu.LuaUnit.run())
