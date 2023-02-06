import SwiftUI

struct CardSummaryView: View {
    let card: Card
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(card.name)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .padding(.bottom, 6)
                    
                    Text("• " + card.shortNumber)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Text(card.balance.description + "₽")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(Colors.lightBlue)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("cardIcon")
                .resizable()
                .frame(width: 30, height: 20)
        }
    }
}

struct CardSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        CardSummaryView(card: TestData.card)
    }
}
