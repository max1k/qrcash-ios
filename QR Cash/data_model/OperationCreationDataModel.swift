import Foundation


class OperationCreationDataModel: ObservableObject, Statused {
    
    @Published
    private(set) var orderId: String?
    
    @Published
    private(set) var status: DataModelStatus = .initializing
    
    
    func createOrder(request: WithdrawalOperationRequest, sessionData: SessionData) {
        guard status == .initializing else { return }
        status = .loading
        
        let _ = qrCashService.createOperation(operationRequest: request, sessionData: sessionData)
            .onResult(handleOperationCreate)
            .onError(handleRequestError)
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
}
