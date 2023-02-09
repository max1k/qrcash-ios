import SwiftUI

struct OtpCodeView: View {
    let sessionData: SessionData
    let operation: OperationWithCommission
    let confirmDataModel: WithdrawalConfirmDataModel
    
    init(sessionData: SessionData, operation: OperationWithCommission, confirmDataModel: WithdrawalConfirmDataModel) {
        self.sessionData = sessionData
        self.operation = operation
        self.confirmDataModel = confirmDataModel
    }
    
    @StateObject
    private var dataModel: OtpCodeDataModel = OtpCodeDataModel()
    
    @State
    private var code: String = ""
    
    @FocusState
    private var codeFocused: Bool
    
    var header: some View {
        Text("Подтвердите операцию\nкодом из СМС")
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
                SecureField("Код", text: $code)
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
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $dataModel.codeCheckIsPassed) {
                OperationCompletedView(operation: operation)
            }
            .navigationDestination(isPresented: $dataModel.codeCheckIsFailed) {
                ConfirmationErrorView()
            }
            .navigationDestination(isPresented: $dataModel.unexpectedError) {
                OperationErrorView(operationType: .withdraw)
            }
        }
    }
    
    private func onCodeChange(newValue: String) {
        if (newValue.count == confirmDataModel.otpCodeLength) {
            let otpCodeRequest = OtpCodeRequest(orderId: operation.operation.orderId, otpCode: code)
            
            dataModel.otpCodeCheck(request: otpCodeRequest, sessionData: sessionData)
            code = ""
        }
    }
}

struct OtpCodeView_Previews: PreviewProvider {
    static var previews: some View {
        let datamodel = WithdrawalConfirmDataModel()
        datamodel.setOtpCodeLength(codeLenth: 6)
        
        return OtpCodeView(
            sessionData: TestData.sessionData,
            operation: TestData.withdrawOperationWithCommission,
            confirmDataModel: datamodel
        )
    }
}
