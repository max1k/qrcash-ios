import Foundation

class WithdrawalConfirmDataModel: ObservableObject, Statused {
    
    @Published
    private(set) var status: DataModelStatus = .initializing
    @Published
    private(set) var needOtp: Bool = true
    @Published
    private(set) var otpCodeLength: Int = 0
    @Published
    var operationIsConfirmed: Bool = false
    
    
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
        operationIsConfirmed = true
        
        status = .done
    }
}
