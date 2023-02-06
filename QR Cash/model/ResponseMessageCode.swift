import Foundation


enum ResponseMessageCode: Int, Decodable {
    case invalidAtmCode = 40
    case serverError = 50
}
