import Foundation

struct AccountSummary: Decodable {
    let accounts: [Account]
    
    enum CodingKeys: String, CodingKey {
        case accounts
    }
}

struct Account: Decodable {
    let accountNumber: String
    let currency: CurrencyType
    let cards: [Card]

    enum CodingKeys: String, CodingKey {
        case accountNumber, currency, cards
    }
}

enum CurrencyType: String, Decodable{
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"
}

enum CardType: String, Decodable{
    case masterAccount = "MASTER_ACCOUNT"
    case currentAccount = "CURRENT_ACCOUNTт"
    case debetCard = "DEBET_CARD"
    case creditCard = "CREDIT_CARD"
    case prepaidCard = "PREPAID_CARD"
}

struct Card: Decodable {
    let publicId: String
    let name: String
    let maskedNumber: String
    let shortNumber: String
    let balance: Decimal
    let paymentSystem: String
    let systemPlacingName: String
    let cardType: CardType
    
    enum CodingKeys: String, CodingKey {
        case publicId, name, maskedNumber, shortNumber, balance, paymentSystem, systemPlacingName, cardType
    }
}


