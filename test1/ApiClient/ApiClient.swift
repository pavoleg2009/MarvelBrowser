
import Foundation

typealias SearchResult = ([Any]?, String) -> ()

class ApiClient {
    
    let authClient = MarverlAuthentication()
    var session: URLSessionMockable = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage: String = ""
    
    var items: [Any] = []
    
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
//                self.updateSearchResults(data)
                DispatchQueue.main.async {
                    completionHandler(self.items, self.errorMessage)
                }
            }
            
            
        }
        dataTask?.resume()
    }
}
