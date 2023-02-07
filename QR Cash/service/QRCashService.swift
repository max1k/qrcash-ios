import Foundation


let qrCashService = QRCashService(baseUrl: "http://10.224.9.136:8099/qrcash")

class QRCashService {
    
    private let baseUrl: String
    
    private let startUri = "/start"
    private let createUri = "/create"
    private let atmCheckUri = "/atm-code/check"
    private let withdrawalConfirmUri = "/cash-withdrawal/confirm"
    private let otpCheckUri = "/otp-code/check"

    
    
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
    
    private func apiPostCall<Request: Encodable, Response: Decodable>(
        requestBody: Request,
        sessionData: SessionData,
        url: String
    ) -> Call<Response> {
        
        let request: RestApiRequest<Response> = RestApiRequest(
            url: URL(string: url)!,
            httpMethod: .post,
            headers: getHeaders(sessionData),
            body: requestBody
        )
        
        return request.execute()
    }
    
    func start(sessionData: SessionData) -> Call<AccountSummary> {
        let headers = getHeaders(sessionData)
        
        let request: RestApiRequest<AccountSummary> = RestApiRequest(url: URL(string: baseUrl + startUri)!, httpMethod: .get, headers: headers)
        return request.execute()
    }
    
    func createOperation(operationRequest: OperationRequest, sessionData: SessionData) -> Call<OperationResponse> {
        return apiPostCall(requestBody: operationRequest, sessionData: sessionData, url: baseUrl + createUri)
    }
    
    func atmCodeCheck(atmCodeRequest: AtmCodeRequest, sessionData: SessionData) -> Call<AtmCodeResponse> {
        return apiPostCall(requestBody: atmCodeRequest, sessionData: sessionData, url: baseUrl + atmCheckUri)
    }
    
    func withdrawalConfirm(request: WithdrawalConfirmationRequest, sessionData: SessionData ) -> Call<WithdrawalConfirmationResponse> {
        return apiPostCall(requestBody: request, sessionData: sessionData, url: baseUrl + withdrawalConfirmUri)
    }
    
    func otpCodeCheck(otpCodeRequest: OtpCodeRequest, sessionData: SessionData) -> Call<OtpCodeResponse> {
        return apiPostCall(requestBody: otpCodeRequest, sessionData: sessionData, url: baseUrl + otpCheckUri)
    }
}
