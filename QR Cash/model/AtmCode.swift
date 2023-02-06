import Foundation

struct AtmCodeRequest: Encodable {
    let orderId: String
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case orderId, code
    }
}

struct AtmCodeResponse: Decodable {
    let success: Bool
    let commission: Decimal?
    let messageCode: ResponseMessageCode?
    let attemptsRemain: Int?
    
    enum CodingKeys: String, CodingKey {
        case success, commission, messageCode, attemptsRemain
    }
}
