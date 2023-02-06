import SwiftUI

struct CardSelectView: View {
    
    @StateObject
    var dataModel: CardListDataModel
    
    var body: some View {
        Text("Карта списания")
            .font(.system(size: 16))
            .foregroundColor(.secondary)
            .padding(.bottom, 8)
        
        if (dataModel.selectedCard != nil) {
            CardSummaryView(card: dataModel.selectedCard!)
                .contextMenu {
                    ForEach(dataModel.cards, id: \.self.publicId) { card in
                        Button(action: { dataModel.selectCard(card) }) {
                            HStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(card.name)
                                        Text("• " + card.shortNumber)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Text(card.balance.description + "₽")
                                        .font(.system(size: 36))
                                        .foregroundColor(Colors.lightBlue)
                                    
                                }
                                .padding(.trailing, 24)
                                
                                Image("cardIcon")
                                    .resizable()
                                    .frame(width: 30, height: 20)
                            }
                        }
                    }
                }
            
        } else {
            Text("Карта не выбрана")
        }
        
        CommonViews.horizontalDashedLine
    }
}

struct CardSelectView_Previews: PreviewProvider {
    static var previews: some View {
        CardSelectView(dataModel: TestData.cardListDataModel)
    }
}
