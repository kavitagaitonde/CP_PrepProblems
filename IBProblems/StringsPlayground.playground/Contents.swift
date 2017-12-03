//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func strStr(_ haystack: String, _ needle: String) -> Int {
    if (haystack == nil || needle == nil || haystack.count < needle.count) {
        return -1;
    }
    if (haystack.count == 0 && needle.count == 0) {
        return 0;
    } else if (haystack.count > 0 && needle.count == 0) {
        return 0;
    } else if (haystack.count == 0 && needle.count > 0) {
        return 0;
    } else if (haystack.count == needle.count && needle == haystack) {
        return 0;
    }
    let needle = needle.lowercased()
    let haystack = haystack.lowercased()
    let nArr = Array(needle)
    let hArr = Array(haystack)
    var i = 0
    var j = 0
    for i in 0..<haystack.count {
        //check if needle exists with starting point i;
        if  i + needle.count > haystack.count  {
            return -1;
        }
        j = 0
        let start = haystack.index(haystack.startIndex, offsetBy: i)
        let end = haystack.index(haystack.endIndex, offsetBy: i+needle.count - haystack.count)
        let range = start..<end
        //let range = i..<i+needle.count //NSRange(location: i, length: needle.count)
        var str = haystack.substring(with: range)
        print("str = \(str)")
        if str == needle {
            print("found at index = \(i)")
            return i
        }
    }
    return -1;
}