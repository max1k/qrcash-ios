import SwiftUI

struct AmountInputView: View {
    
    let amountChangeListener: (Decimal) -> Void
    
    @State
    private var amount: String = ""
    
    
    var body: some View {
        Text("Сумма")
            .font(.system(size: 16))
            .foregroundColor(Colors.lightBlue)
            .padding(.top, 30)
        
        TextField(
            "₽",
            text: $amount
        )
        .padding(.bottom, 4)
        .onChange(of: amount, perform: onAmountChange)
        .keyboardType(.numberPad)
        
        Divider()
            .background(Colors.lightBlue)
            .frame(minHeight: 5)
        
        Text("Доступные номиналы")
            .font(.system(size: 14))
            .foregroundColor(.secondary)
            .padding(.top, 16)
        
        HStack {
            Text("100 ₽")
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke()
                        .foregroundColor(.gray)
                )
                .onTapGesture {
                    addAmount(100)
                }
            
            Text("500 ₽")
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke()
                        .foregroundColor(.gray)
                )
                .onTapGesture {
                    addAmount(500)
                }
            
            Text("1 000 ₽")
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke()
                        .foregroundColor(.gray)
                )
                .onTapGesture {
                    addAmount(1000)
                }
            
            Text("5000 ₽")
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke()
                        .foregroundColor(.gray)
                )
                .onTapGesture {
                    addAmount(5000)
                }
            
        }
    }
    
    private func addAmount(_ amount: Int) {
        let intAmount = (Int(self.amount) ?? 0) + amount
        self.amount = intAmount.description
        onAmountChange(self.amount)
    }
    
    private func onAmountChange(_ newValue: String) {
        let selectedAmount = Decimal(Int(self.amount) ?? 0)
        amountChangeListener(selectedAmount)
    }
}

struct AmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        AmountInputView(amountChangeListener: {_ in})
    }
}
