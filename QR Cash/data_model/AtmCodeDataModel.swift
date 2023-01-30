import Foundation


class AtmCodeDataModel: ObservableObject, Statused {
    
    @Published private(set) var orderId: String?
    @Published private(set) var status: DataModelStatus = .initializing
    
    
    func createOrder(request: WithdrawalOperationRequest, sessionData: SessionData) {
        guard status == .initializing else { return }
        status = .loading
        
        qrCashService.createOperation(request: request, sessionData: sessionData) { response in
            if ((response?.success ?? false) && (response?.orderId != nil)) {
                self.status = .done
                self.orderId = response?.orderId
            } else {
                self.status = .error
            }
        }
    }
    
    func atmCodeCheck(atmCode: String, sessionData: SessionData) {
        
    }
}
