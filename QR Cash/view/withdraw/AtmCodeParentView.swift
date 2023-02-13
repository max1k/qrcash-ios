import SwiftUI

struct AtmCodeParentView: View {
    let sessionData: SessionData
    let card: Card
    let amount: Decimal
    let codeLength: Int
    
    @StateObject
    private var dataModel: OperationCreationDataModel = OperationCreationDataModel()
    
    var body: some View {
        Group {
            switch dataModel.status {
            case .done:
                ATMCodeInputView(
                    sessionData: sessionData,
                    operation: Operation(
                        card: card,
                        type: .withdraw,
                        orderId: dataModel.orderId!,
                        amount: amount
                    ),
                    codeLength: codeLength
                )
            case .loading, .initializing:
                ProgressView()
            case .error:
                OperationErrorView(operationType: .withdraw)
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
        dataModel.createOperation(request: request, sessionData: sessionData)
    }
}

struct ATMCodeInputView: View {
    let sessionData: SessionData
    let operation: Operation
    let codeLength: Int
    
    @StateObject
    private var dataModel: AtmCodeDataModel = AtmCodeDataModel()
    
    @State
    private var code: String = ""
    
    @FocusState
    private var codeFocused: Bool
    
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
            let codeIsInvalid = dataModel.checkStatus == .invalidCode
            let mainColor = codeIsInvalid ? .red : Colors.lightBlue
            VStack {
                TextField("Код", text: $code)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .onChange(of: code, perform: onCodeChange)
                    .focused($codeFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                          self.codeFocused = true
                        }
                    }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(mainColor)
            }
            .padding([.leading, .trailing], 96)
            
            if (codeIsInvalid) {
                Text("Неправильный код. Осталось попыток: " + (dataModel.checkResponse?.attemptsRemain?.description ?? "0"))
                    .foregroundColor(mainColor)
            }
        }
        .padding(.bottom, 48)
    }
    
    var atmLocationSection: some View {
        Text("Вы находитесь у банкомата № **12584** по адресу: г. Москва, наб. Космодамианская, д. 52")
            .font(.system(size: 16))
    }
    
    var body: some View {
        NavigationStack {
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
            .navigationDestination(isPresented: $dataModel.codeCheckIsPassed) {
                WithdrawalConfirmView(
                    sessionData: sessionData,
                    operation: OperationWithCommission(
                        operation: operation,
                        commission: dataModel.checkResponse?.commission ?? 0,
                        describedType: .withdraw
                    )
                )
            }
            .navigationDestination(isPresented: $dataModel.codeCheckIsFailed) {
                ConfirmationErrorView()
            }
            .navigationDestination(isPresented: $dataModel.unexpectedError) {
                OperationErrorView(operationType: .withdraw)
            }
        }
    }
    
    private func onCodeChange(_ newValue: String) {
        if (newValue.count == codeLength) {
            let atmCodeRequest = AtmCodeRequest(orderId: operation.orderId, code: code)
            
            dataModel.atmCodeCheck(atmCodeRequest: atmCodeRequest, sessionData: sessionData)
            code = ""
        }
    }
}

struct AtmCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ATMCodeInputView(
            sessionData: TestData.sessionData,
            operation: TestData.withdrawOperation,
            codeLength: 4
        )
    }
}
