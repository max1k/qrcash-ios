import Foundation


class OtpCodeDataModel: ObservableObject {
    @Published
    private(set) var checkStatus: CodeCheckStatus = .initializing
    
    @Published
    private(set) var checkResponse: OtpCodeResponse? = nil
    
    @Published
    var codeCheckIsPassed: Bool = false
    
    @Published
    var codeCheckIsFailed: Bool = false
    
    @Published
    var unexpectedError: Bool = false
    
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
            
            if (messageCode == .allAttemptsOtpCodeExhausted) {
                codeCheckIsFailed = true
                checkStatus = .attemptsExhausted
                return
            }
        }
        
        checkStatus = .error
    }
    
    func handleError(error: Error) {
        unexpectedError = true
        checkStatus = .error
    }
}
