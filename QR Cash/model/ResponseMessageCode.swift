import Foundation


enum ResponseMessageCode: Int, Decodable {
    case invalidAtmCode = 40
    case allAttemptsAtmCodeExhausted = 41
    case invalidOtpCode = 42
    case allAttemptsOtpCodeExhausted = 43    
    case serverError = 50
}
