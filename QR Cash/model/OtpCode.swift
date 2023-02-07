import Foundation


struct OtpCodeRequest: Encodable {
    let orderId: String
    let otpCode: String
}

struct OtpCodeResponse: Decodable {
    let success: Bool
    let messageCode: ResponseMessageCode?
    let attemptsRemain: Int?
}
