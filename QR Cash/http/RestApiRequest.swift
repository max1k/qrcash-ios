import Foundation


class RestApiRequest<T: Decodable> {
    let url: URL
    let httpMethod: HttpMethod
    let body: Encodable?
    let headers: Dictionary<String, String>?
    
    init(url: URL, httpMethod: HttpMethod, headers: Dictionary<String, String>? = nil, body: Encodable? = nil) {
        self.url = url
        self.httpMethod = httpMethod
        self.body = body
        self.headers = headers
    }
    
    func load(request: URLRequest, withCompletion completion: @escaping (T?) -> Void, errorHandler: @escaping () -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, _ , requestError) -> Void in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                } catch {
                    print(error)
                }
            } else {
                print(requestError.debugDescription)
                errorHandler()
            }
        }
        
        task.resume()
    }
    
    func execute(withCompletion completion: @escaping (T?) -> Void, errorHandler: @escaping () -> Void = {}) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if (body != nil) {
            request.httpBody = try? JSONEncoder().encode(body!)
        }
        
        if (headers != nil) {
            headers?.forEach({ request.setValue($1, forHTTPHeaderField: $0) })
        }
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        load(request: request, withCompletion: completion, errorHandler: @escaping () -> Void = {})
    }
}
