import SwiftUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

class CommonViews {
    static var withdrawalTroublesHotline: some View {
        Text("Если у вас возникли проблемы со снятием наличных, звоните по номеру:\n[8 800 123-45-67](tel://88001234567)")
            .font(.system(size: 16))
            .multilineTextAlignment(.leading)
    }
    
    static var navigationBack: some View {
        NavigationLink(destination: OperationChooseView()) {
            Image(systemName: "chevron.left")
        }
    }
    
    static var navigationClose: some View {
        NavigationLink(destination: OperationChooseView()) {
            Image(systemName: "xmark")
                .foregroundColor(Colors.lightBlue)
        }
    }
    
    static var horizontalDashedLine: some View {
        Line()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .frame(height: 1)
            .foregroundColor(Colors.lightBlue)
            .padding(.top, 0)
    }
}

struct DetailView: View {
    let header: String
    let value: String
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .padding(.bottom, 8)
                .multilineTextAlignment(.leading)
            
            Text(value)
                .font(.system(size: 16))
            
            CommonViews.horizontalDashedLine
                .padding(.bottom, 28)
            
        }
    }
}

struct CardSectionView: View {
    let card: Card
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Карта списания")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .padding(.bottom, 0)
                .multilineTextAlignment(.leading)
            
            CardSummaryView(card: card)
            
            CommonViews.horizontalDashedLine
                .padding(.bottom, 28)
        }
    }
}
