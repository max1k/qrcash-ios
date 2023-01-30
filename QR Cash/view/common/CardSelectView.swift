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
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(dataModel.selectedCard!.name)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .padding(.bottom, 6)
                        
                        Text("• " + dataModel.selectedCard!.shortNumber)
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                    }
                    
                    Text(dataModel.selectedCard!.balance.description + "₽")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Colors.lightBlue)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Image("cardIcon")
                    .resizable()
                    .frame(width: 30, height: 20)
            }
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
        
        Line()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .frame(height: 1)
            .foregroundColor(Colors.lightBlue)
            .padding(.top, 0)
    }
}

struct CardSelectView_Previews: PreviewProvider {
    static var previews: some View {
        CardSelectView(dataModel: TestData.cardListDataModel)
    }
}
