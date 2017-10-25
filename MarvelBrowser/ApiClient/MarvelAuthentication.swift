//
//  MarverlAuthentication.swift
//
//  Created by Oleg Pavlichenkov on 17/10/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

import UIKit

class MarverlAuthentication: NSObject {
    
    private var _timestamp: String!
    var timestamp: String {
        get {
            if _timestamp == nil {
                _timestamp = Date().timeIntervalSinceReferenceDate.description
            }
            return _timestamp
        }
        set {
            _timestamp = newValue
        }
    }
    
    private var _publicKey: String!
    var publicKey: String {
        get {
            if _publicKey == nil {
                _publicKey = Api.publicKey
            }
            return _publicKey
        }
        set {
            _publicKey = newValue
        }
    }
    
    private var _privateKey: String!
    var privateKey: String {
        get {
            if _privateKey == nil {
                _privateKey = Api.privateKey
            }
            return _privateKey
        }
        set {
            _privateKey = newValue
        }
    }
    
    var timestampedKeys: String {
        return "\(timestamp)\(privateKey)\(publicKey)"
    }
    
    var urlParameters: String {
        return "&ts=\(timestamp)&apikey=\(publicKey)&hash=\(MD5(string:timestampedKeys))"
    }
    
    //https://stackoverflow.com/questions/32163848/how-to-convert-string-to-md5-hash-using-ios-swift
    func MD5(string:String) -> String {
        let stringData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))

        _ = digestData.withUnsafeMutableBytes {digestBytes in
            stringData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(stringData.count), digestBytes)
            }
        }
        
        let md5Hex = digestData.map { String(format: "%02hhx", $0) }.joined()
        
        return md5Hex
    }
}
