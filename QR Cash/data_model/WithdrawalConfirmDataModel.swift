import Foundation

class WithdrawalConfirmDataModel {
    @Published
    private(set) var status: DataModelStatus = .initializing
    @Published
    private(set) var needOtp: Bool = true
    @Published
    private(set) var otpCodeLength: Int = 0
    
    
    func confirmOperation(confirmRequest: WithdrawalConfirmationRequest, sessionData: SessionData) {
        guard status != .loading else { return }
        status = .loading
        
        let _ = qrCashService.withdrawalConfirm(request: confirmRequest, sessionData: sessionData)
            .onResult(handleResponse)
            .onError(handleError)
    }
    
    private func handleError(error: Error) {
        status = .error
    }
    
    private func handleResponse(response: WithdrawalConfirmationResponse) {
        if !response.success {
            status = .error
        }
        
        needOtp = response.needOtp!
        otpCodeLength = response.countNum ?? 0
        
        status = .done
    }
}
