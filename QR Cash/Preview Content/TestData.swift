import Foundation

class TestData {
    static var cardListDataModel: CardListDataModel {
        let dataModel = CardListDataModel()
        dataModel.setCards([card])
        return dataModel
    }
    
    static let sessionData = SessionData(uncId: "123456", mdmId: "123456", atmId: "000000")
    
    static let card = Card(
        publicId: "123",
        name: "Цифровая карта",
        maskedNumber: "220024******0923",
        shortNumber: "0923",
        balance: 55000,
        paymentSystem: "MIR",
        systemPlacingName: "WWWF",
        cardType: .prepaidCard
    )
    
    static let withdrawOperation = Operation(card: card, type: .withdraw, orderId: "111", amount: 100)
    
    static let withdrawOperationWithCommission = OperationWithCommission(operation: withdrawOperation, commission: 10.0)
}
