import SwiftUI

struct OperationCompletedView: View {
    let operation: OperationWithCommission
    
    private var continueButton: some View {
        NavigationLink(destination: OperationChooseView()) {
             Text("Готово")
                 .font(.system(size: 16))
                 .frame(maxWidth: .infinity)
                 .padding([.top, .bottom], 8)
         }
         .buttonStyle(.borderedProminent)
         .frame(maxHeight: .infinity, alignment: .bottom)
         .padding([.bottom, .leading, .trailing], 16)
    }
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 65, height: 65)
                .foregroundColor(Colors.lightBlue)
                .padding(.top, 36)
                .padding(.bottom, 32)
            
            Text(operation.describedType.rawValue)
                .font(.system(size: 22))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 4)
            
            Text("10 Июля 2021, 20:31")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .padding(.bottom, 24)
            
            Text("\(operation.operation.amount.description) ₽")
                .font(.system(size: 32))
                .foregroundColor(.black)
                .fontWeight(.bold)
            
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .padding(.bottom, -20)
                
                VStack {
                    CardSectionView(card: operation.operation.card)
                        .padding(.top, 16)
                    
                    DetailView(
                        header: "Комиссия",
                        value: "\(operation.operation.amount.description),00 ₽"
                    )
                    
                    continueButton
                }
                .padding([.leading, .trailing], 16)
            }
            
        }
        .background(Colors.bgLightGray)
        .navigationBarBackButtonHidden(true)
    }
}

struct OperationCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        OperationCompletedView(operation: TestData.withdrawOperationWithCommission)
    }
}
