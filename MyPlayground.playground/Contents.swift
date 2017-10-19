//: Playground - noun: a place where people can play

import UIKit

var str = "2014-03-25T13:30:33-0400"

let RFC3339DateFormatter = DateFormatter()
RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'-'SSSS"
RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
let date = RFC3339DateFormatter.date(from: str)


let DateToStringFormatter = DateFormatter()
DateToStringFormatter.locale = Locale(identifier: "ru_RU")
DateToStringFormatter.dateFormat = "dd.MM.yyyy' 'HH:mm:ss'['SSSS']'"
DateToStringFormatter.timeZone = TimeZone(secondsFromGMT: 0)
let string = DateToStringFormatter.string(from: date!)

