import Foundation

typealias SearchResult = ([Character], String?) -> ()

class ApiClient {
    
    /* API for querying Marvel API (https://developer.marvel.com/)
     - Run query data task, store results in array of Characters
     */
    
    private static let _shared = ApiClient()
    static var shared: ApiClient {
        return _shared
    }
    private init(){}
    
    let authClient = MarverlAuthentication()
    var session: URLSessionMockable = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage: String = ""
    
    var characters: [Character] = []
    
    func getSearchResults(searchTerm: String, completionHandler: @escaping SearchResult) {
        
        dataTask?.cancel()
        
        guard let url = URL(string: "\(Api.baseURLString)\(Api.charactersSearchPath)\(searchTerm)\(authClient.urlParameters)")
            else { return }
        
        dataTask = session.dataTask(with: url) { (data, response, error) in
            defer { self.dataTask = nil }
            
            if let error = error {
                self.errorMessage.append("\(error)\n")
            } else if let data = data,
            let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                self.updateSearchResults(data)
                DispatchQueue.main.async {
                    completionHandler(self.characters, self.errorMessage)
                }
            }
        }
        dataTask?.resume()
    }
    
    func updateSearchResults(_ data: Data) {
        var jsonResponse: [String:Any]!
        characters.removeAll()
        
        do {
            jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        } catch let parseError as NSError {
            errorMessage.append("\(parseError.debugDescription)\n")
            return
        }
        
        guard
            let jsonData = jsonResponse["data"] as? [String : Any],
            let jsonArray = jsonData["results"] as? [[String : Any]]
        
        else {
            errorMessage.append("Could not find array with items in response\n")
            return
        }
        characters = Character.array(jsonArray: jsonArray)
    }
}
