import Foundation


struct WithdrawalConfirmationRequest: Encodable {
    let orderId: String
}

struct WithdrawalConfirmationResponse: Decodable {
    let success: Bool
    let messageCode: ResponseMessageCode?
    let needOtp: Bool?
    let countNum: Int?
    let timeoutResend: Int?
    
    enum CodingKeys: String, CodingKey {
        case success, messageCode, needOtp, countNum, timeoutResend
    }
}
