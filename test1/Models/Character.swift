import Foundation

// Api result example for characters
/*
 {
 "id":1009157,
 "name":"Spider-Girl (Anya Corazon)",
 "description":" ",
 "modified":"2013-12-17T16:00:02-0500",
 "thumbnail":{
     "path":"http://i.annihil.us/u/prod/marvel/i/mg/a/10/528d369de3e4f",
     "extension":"jpg"
     },
 "resourceURI":"http://gateway.marvel.com/v1/public/characters/1009157",
 "comics":{  },
 "series":{  },
 "stories":{  },
 "events":{  },
 "urls":[  ]
 }
 
*/

/**/
class Character: NSObject {
    
    // MARK: - Instance Properties
    var id: Int
    var name: String
    var characterDescription: String
    var modified: Date
//    var thumbnailPath: String
    
    // MARK: Life Cycle
    public init(id: Int, name: String, characterDescription: String, modified: Date/*, thumbnailPath: String*/) {
        
        self.id = id
        self.name = name
        self.characterDescription = characterDescription
        self.modified = modified
//        self.thumbnailPath = thumbnailPath
    }
    
    override public var description: String {
        return "\(self.name) (\(self.id))"
    }
}

extension Character {
    // MARK: Init with Json
    public convenience init?(json: [String:Any]) {
        guard
            let id = json[Character.ApiKeys.id] as? Int,
            let name = json[Character.ApiKeys.name] as? String,
            let characterDescription = json[Character.ApiKeys.characterDescription] as? String,
            let modifiedString = json[Character.ApiKeys.modified] as? String,
            let modified = Character.stringToDateFormatter.date(from: modifiedString)
            //            let thumbnailPath = json[]
            else { return nil }
        
        self.init(id: id,
                  name: name,
                  characterDescription: characterDescription,
                  modified: modified/*, thumbnailPath: */
        )
    }
    
    public class func array(jsonArray:[[String:Any]]) ->[Character] {
        var array: [Character] = []
        for json in jsonArray {
            guard let character = Character(json:json) else { continue }
            array.append(character)
        }
        print("=== Parced Character items from JSON: \(array.count)")
        return array
    }
}

extension Character {
    struct ApiKeys {
        static let id = "id"
        static let name = "name"
        static let characterDescription = "description"
        static let modified = "modified"
        //
        static let thumbnailPath = "thumbnail.path"
        static let thumbnailExtension = "thumbnail.path"
    }
}

extension Character {
    static let stringToDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'-'SSSS"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        return df
        //let date = df.date(from: str)
    }()
    
    static let dateToStringFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_RU")
        df.dateFormat = "dd.MM.yyyy' 'HH:mm:ss'['SSSS']'"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        //let string = df.string(from: date!)
        return df
    }()
}
