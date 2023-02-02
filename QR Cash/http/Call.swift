import Foundation


class Call<T: Decodable> {
    var body: T? = nil
    var error: Error? = nil
    
    private var resultHandler: ((T) -> Void)? = nil
    private var errorHandler: ((Error) -> Void)? = nil
    
    var onResult: ((T) -> Void)? {
        set {
            resultHandler = newValue
            complete()
        }
        
        get {
            return resultHandler
        }
    }
    
    var onError: ((Error) -> Void)? {
        set {
            errorHandler = newValue
            complete()
        }
        
        get {
            return errorHandler
        }
        
    }
    
    func complete() {
        if let body = body, let onResult = resultHandler {
            DispatchQueue.main.async {
                onResult(body)
            }
        } else if let error = error, let onError = errorHandler {
            DispatchQueue.main.async {
                onError(error)
            }
        }
    }
    
}
