import Foundation


class OtpCodeDataModel: ObservableObject {
    @Published
    private(set) var checkStatus: CodeCheckStatus = .initializing
    
    @Published
    private(set) var checkResponse: OtpCodeResponse? = nil
    
    @Published
    var codeCheckIsPassed: Bool = false
    
    func otpCodeCheck(request: OtpCodeRequest, sessionData: SessionData) {
        guard checkStatus != .loading else { return }
        checkStatus = .loading
        
        let _ = qrCashService.otpCodeCheck(otpCodeRequest: request, sessionData: sessionData)
            .onResult(handleResponse)
            .onError(handleError)
    }
    
    func handleResponse(response: OtpCodeResponse) {
        checkResponse = response
        
        if (response.success) {
            checkStatus = .done
            codeCheckIsPassed = true
            return
        }
        
        if let messageCode = response.messageCode {
            if (messageCode == .invalidOtpCode) {
                checkStatus = .invalidCode
                return
            }
        }
        
        checkStatus = .error
    }
    
    func handleError(error: Error) {
        checkStatus = .error
    }
}
