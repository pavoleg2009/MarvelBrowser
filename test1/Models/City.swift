import UIKit

public final class City: NSObject {
    
    // MARK: - API Reust sample from JSON response
    //    "cid": 1112583,
    //    "title": "1 Военный",
    //    "important": 1
    //    "area": "Карабаш город",
    //    "region": "Челябинская область"
    
    // MARK: - Instance Properties
    var cid: Int?
    var title: String
    var important: Int?
    var area: String?
    var region: String?
    
    // MARK: - Object lifecycle
    public init?(json: [String:Any]) {
        
        guard let cid = json[City.ApiKeys.cid] as? Int,
            let title = json[City.ApiKeys.title] as? String
            else { return nil }
        
        self.cid = cid
        self.title = title
        
        self.important = json[City.ApiKeys.important] as? Int ?? 0
        self.area = json[City.ApiKeys.area] as? String
        self.region = json[City.ApiKeys.region] as? String
    }
    
    public init(cid: Int,
                title: String,
                important: Int? = nil,
                area: String? = nil,
                region: String? = nil) {

        self.cid = cid
        self.title = title
        self.important = important
        self.area = area
        self.region = region
    }
    
    override public var description: String {
        return "\(self.title) (\(self.cid ?? -1))"
    }
    
    public class func array(jsonArray:[[String:Any]]) ->[CityDTS] {
        var array: [CityDTS] = []
        for json in jsonArray {
            guard let city = CityDTS(json:json) else { continue }
            array.append(city)
        }
        print("=== Parced City items from JSON: \(array.count)")
        return array
    }
}
protocol SQLTable {
    static var createStatement: String { get }
}

extension CityDTS: SQLTable {
    static var createStatement: String {
        return """
        CREATE TABLE City(
        \(City.SQLiteKeys.id) INT PRIMARY KEY NOT NULL,
        \(City.SQLiteKeys.title) CHAR(255),
        \(City.SQLiteKeys.cid) INT,
        \(City.SQLiteKeys.important) INT,
        \(City.SQLiteKeys.area) CHAR(255),
        \(City.SQLiteKeys.region) CHAR(255)
        );
        """
    }

    
}
