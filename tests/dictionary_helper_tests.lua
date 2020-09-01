dh = require('helpers.dictionary_helper')
lu = require('luaunit')

funcs = {
    x2 = function(i)
        return i * 2
    end,
    checkEven = function(i)
        return i % 2 == 0
    end
}

TestDictionaryHelper = {
    tests = {
        abs = {
            _TEST_ = function(test)
                local result = dh:make(test.input):abs():get()
                lu.assertEquals(result, test.output)
            end,
            tests = {{
                input = {
                    age = 20,
                    height = 30
                },
                output = {
                    age = 20,
                    height = 30
                }
            }, {
                input = {
                    age = -21,
                    height = 121
                },
                output = {
                    age = 21,
                    height = 121
                }
            }}
        },
        all = {
            _TEST_ = function(test)
                local result = dh:make(test.input):all(test.fn)
                lu.assertEquals(result, test.output)
            end,
            tests = {{
                input = {
                    age = 21,
                    height = 180
                },
                fn = funcs.checkEven,
                output = false
            }, {
                input = {
                    age = 22,
                    height = 180
                },
                fn = funcs.checkEven,
                output = true
            }}
        },
        any = {
            _TEST_ = function(test)
                local result = dh:make(test.input):any(test.fn)
                lu.assertEquals(result, test.output)
            end,
            tests = {{
                input = {
                    age = 21,
                    height = 181
                },
                fn = funcs.checkEven,
                output = false
            }, {
                input = {
                    age = 28,
                    height = 181
                },
                fn = funcs.checkEven,
                output = true
            }}
        },
        filter = {
            _TEST_ = function(test)
                local result = dh:make(test.input):filter(test.fn):get()
                lu.assertEquals(result, test.output)
            end,
            tests = {{
                input = {
                    age1 = 28,
                    age2 = 31,
                    age3 = 44
                },
                fn = funcs.checkEven,
                output = {
                    age1 = 28,
                    age3 = 44
                }
            }, {
                input = {
                    age1 = 21
                },
                fn = funcs.checkEven,
                output = {}
            }, {
                input = {},
                fn = funcs.checkEven,
                output = {}
            }}
        },
        map = {
            _TEST_ = function(test)
                local result = dh:make(test.input):map(test.fn):get()
                lu.assertEquals(result, test.output)
            end,
            tests = {{
                input = {
                    age = 28,
                    height = 182
                },
                fn = funcs.x2,
                output = {
                    age = 56,
                    height = 364
                }
            }, {
                input = {
                    fname = "chris",
                    lname = "evans"
                },
                fn = string.reverse,
                output = {
                    fname = "sirhc",
                    lname = "snave"
                }
            }}
        }
    }
}

function TestDictionaryHelper:testDictionary()
    for k, v in pairs(self.tests) do
        print(string.format("Running %s tests", k))

        for i, test in ipairs(v.tests) do
            print(string.format("Running test %d of %d", i, #v.tests))
            v._TEST_(test)
        end
    end
end

os.exit(lu.LuaUnit.run())
