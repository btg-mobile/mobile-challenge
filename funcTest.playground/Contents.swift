import Cocoa

var str = "Hello, playground"


let value = 300
value.isBetween(v1: 299, v2: 301)
value.isBetween(v1: 300, v2: 299)

value.isBetween(v1: -299, v2: 3301)
value.isBetween(v1: 400, v2: 405)
value.isBetween(v1: 405, v2: 400)

value.isBetween(v1: -400, v2: -405)
value.isBetween(v1: -400, v2: 299)


extension Int {
        func isBetween(v1: Int, v2: Int) -> Bool {
        let (bigger, smaller) = v1 > v2 ? (v1, v2) : (v2, v1)
        return self <= bigger && self >= smaller
    }
}
