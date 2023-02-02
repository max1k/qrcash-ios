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
        Text("Если у вас возникли проблемы со снятием наличных, звоните по номеру:\n[8 800 100-24-24](tel://88001002424)")
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
        }
    }
}
