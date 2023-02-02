import SwiftUI

struct AtmCodeParentView: View {
    let sessionData: SessionData
    let card: Card
    let amount: Decimal
    let codeLength: Int
    
    @StateObject
    private var dataModel: AtmCodeDataModel = AtmCodeDataModel()
    
    var body: some View {
        Group {
            switch dataModel.status {
            case .done:
                ATMCodeInputView(
                    sessionData: sessionData,
                    card: card, amount: amount,
                    codeLength: codeLength,
                    dataModel: dataModel
                )
            case .loading, .initializing:
                ProgressView()
            case .error:
                WithdrawErrorView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: createOperationRequest)
    }
    
    func createOperationRequest() {
        let request = WithdrawalOperationRequest(
            atmId: sessionData.atmId,
            amount: amount,
            publicId: card.publicId,
            commission: amount / 100
        )
        dataModel.createOrder(request: request, sessionData: sessionData)
    }
}

struct ATMCodeInputView: View {
    let sessionData: SessionData
    let card: Card
    let amount: Decimal
    let codeLength: Int
    let dataModel: AtmCodeDataModel
    
    @State
    private var code: String = ""
    
    var header: some View {
        Text("Введите код с экрана\nбанкомата")
            .font(.system(size: 22))
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .padding(.top, 24)
            .padding(.bottom, 58)
    }
    
    var codeInputField: some View {
        VStack {
            SecureField("Код", text: $code)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .onChange(of: code, perform: onCodeChange)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Colors.lightBlue)
        }
            .padding([.leading, .trailing], 96)
            .padding(.bottom, 48)
    }
    
    var atmLocationSection: some View {
        Text("Вы находитесь у банкомата № **12584** по адресу: г. Москва, наб. Космодамианская, д. 52")
            .font(.system(size: 16))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            CommonViews.navigationClose
                .frame(maxWidth: .infinity, alignment: .leading)
            header
            codeInputField
            atmLocationSection
            CommonViews.withdrawalTroublesHotline
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 16)
        }
        .padding([.leading, .trailing], 16)
        .navigationBarBackButtonHidden(true)
    }
    
    private func onCodeChange(_ newValue: String) {
        if (newValue.count == codeLength) {
            
        }
    }
}

struct AtmCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ATMCodeInputView(sessionData: TestData.sessionData, card: TestData.card, amount: 100, codeLength: 4, dataModel: AtmCodeDataModel())
    }
}
