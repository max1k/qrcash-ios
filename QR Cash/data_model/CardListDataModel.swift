import Foundation


class CardListDataModel: ObservableObject, Statused {
    
    @Published private(set) var cards: [Card] = []
    @Published private(set) var selectedCard: Card?
    @Published private(set) var status: DataModelStatus = .initializing
    
    
    func getCards(sessionData: SessionData) {
        guard status == .initializing else { return }
        status = .loading
        
        qrCashService.start(sessionData: sessionData) { accountSummary in
            self.status = .done
            self.setCards(accountSummary?.accounts.flatMap({$0.cards}) ?? [])
        }
    }
    
    func setCards(_ cards: [Card]) {
        self.cards = cards
        if (cards.count > 0) {
            self.selectedCard = cards.first
        }
    }
    
    func selectCard(_ card: Card) {
        self.selectedCard = card
    }
}
