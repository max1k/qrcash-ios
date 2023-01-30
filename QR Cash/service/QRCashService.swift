import Foundation


let qrCashService = QRCashService(baseUrl: "http://10.224.9.136:8099/qrcash")

class QRCashService {
    
    private let baseUrl: String
    
    private let startUri = "/start"
    private let createUri = "/create"

    
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    private func getHeaders(_ sessionData: SessionData) -> Dictionary<String, String> {
        return [
            HeaderConsts.uncHeaderName:sessionData.uncId,
            HeaderConsts.mdmHeaderName: sessionData.mdmId,
            HeaderConsts.channelHeaderName: HeaderConsts.mobileBankHeader,
            HeaderConsts.userSessionHeaderName: UUID().description]
    }
    
    func start(sessionData: SessionData, onLoad: @escaping (AccountSummary?) -> Void) {
        let headers = getHeaders(sessionData)
        
        let request: RestApiRequest<AccountSummary> = RestApiRequest(url: URL(string: baseUrl + startUri)!, httpMethod: .get, headers: headers)
        request.execute(withCompletion: onLoad)
    }
    
    func createOperation(request: OperationRequest, sessionData: SessionData, onLoad: @escaping (OperationResponse?) -> Void) {
        let headers = getHeaders(sessionData)
        
        let request: RestApiRequest<OperationResponse> = RestApiRequest(
            url: URL(string: baseUrl + createUri)!,
            httpMethod: .post,
            headers: headers,
            body: request
        )
        
        request.execute(withCompletion: onLoad)
    }
}
