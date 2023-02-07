import Foundation


enum OperationType: String, Encodable {
    case withdraw = "cashWithDrawal"
    case deposit = "cashDeposit"
}

enum OperationTypeDescribed: String {
    case withdraw = "Выдача наличных"
    case deposit = "Внесение наличных"
}

struct Operation {
    let card: Card
    let type: OperationType
    let orderId: String
    let amount: Decimal
}

struct OperationWithCommission {
    let operation: Operation
    let commission: Decimal
    let describedType: OperationTypeDescribed
}

//MARK: Operation request
protocol OperationRequest: Encodable {
    var operationType: OperationType { get }
    var publicId: String { get }
}

struct WithdrawalOperationRequest: OperationRequest {
    let atmId: String
    let operationType: OperationType = .withdraw
    let amount: Decimal
    let publicId: String
    let commission: Decimal
    
    enum CodingKeys: String, CodingKey {
        case operationType, amount, publicId, commission
        case atmId = "ATMNUM"
    }
}

struct DepositOperationRequest: OperationRequest {
    let atmId: String
    let operationType: OperationType = .deposit
    let publicId: String
    
    enum CodingKeys: String, CodingKey {
        case operationType, publicId
        case atmId = "ATMNUM"
    }
}

//MARK: Operation response
struct OperationResponse: Decodable {
    let orderId: String?
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case orderId, success
    }
}
