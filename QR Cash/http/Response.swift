import Foundation


class Response<T: Decodable> {
    var body: T? = nil
    var error: Error? = nil
    
    var onResult: (T) -> Void {
        set {
            self.onResult = newValue
            if (body != nil) {
                onResult(body!)
            }
        }
        
        get { return self.onResult }
    }
    
    var onError: (Error) -> Void {
        set {
            self.onError = newValue
            if (error != nil) {
                onError(error!)
            }
        }
        
        get { return self.onError }
    }
    
}
