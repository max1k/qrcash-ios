import Foundation


class AtmCodeDataModel: ObservableObject, Statused {
    
    @Published private(set) var orderId: String?
    @Published private(set) var status: DataModelStatus = .initializing
    
    
    func createOrder(request: WithdrawalOperationRequest, sessionData: SessionData) {
        guard status == .initializing else { return }
        status = .loading
        
        let call: Call<OperationResponse> = qrCashService.createOperation(request: request, sessionData: sessionData)
        
        call.onResult = handleOperationCreate
        call.onError = handleRequestError
    }
    
    private func handleOperationCreate(response: OperationResponse) {
        if response.success && response.orderId != nil {
            status = .done
            orderId = response.orderId
        } else {
            status = .error
        }
    }
    
    private func handleRequestError(error: Error) {
        status = .error
    }
    
    func atmCodeCheck(atmCode: String, sessionData: SessionData) {
        
    }
}
