import Foundation


class AtmCodeDataModel: ObservableObject {
    
    @Published private(set) var checkStatus: AtmCodeStatus = .initializing
    @Published private(set) var checkResponse: AtmCodeResponse?
    @Published var codeCheckIsPassed: Bool = false
    
    
    
    func atmCodeCheck(atmCodeRequest: AtmCodeRequest, sessionData: SessionData) {
        guard checkStatus != .loading else { return }
        checkStatus = .loading
        
        let _ = qrCashService.atmCodeCheck(atmCodeRequest: atmCodeRequest, sessionData: sessionData)
            .onResult(handleAtmCodeResponse)
            .onError(handleAtmCodeError)
    }
    
    private func handleAtmCodeError(error: Error) {
        checkStatus = .error
    }
    
    private func handleAtmCodeResponse(response: AtmCodeResponse) {
        checkResponse = response
        
        if (response.success) {
            checkStatus = .done
            codeCheckIsPassed = true
            return
        }
        
        if let messageCode = response.messageCode {
            if (messageCode == .invalidAtmCode) {
                checkStatus = .invalidCode
                return
            }
        }
        
        checkStatus = .error
    }
}
