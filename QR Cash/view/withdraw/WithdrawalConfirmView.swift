import SwiftUI

struct WithdrawalConfirmView: View {
    let sessionData: SessionData
    let operation: OperationWithCommission
    
    @StateObject
    private var dataModel: WithdrawalConfirmDataModel = WithdrawalConfirmDataModel();
    
    var header: some View {
        Text("Подтвердите снятие наличных")
            .font(.system(size: 22))
            .fontWeight(.bold)
            .padding(.top, 16)
            .padding(.bottom, 32)
    }
    
    var cardSection: some View {
        VStack(alignment: .leading) {
            Text("Карта списания")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .padding(.bottom, 0)
                .multilineTextAlignment(.leading)
            
            CardSummaryView(card: operation.operation.card)
            
            CommonViews.horizontalDashedLine
                .padding(.bottom, 28)
        }
    }
    
    var withdrawalDetails: some View {
        ScrollView(showsIndicators: false) {
            header
            cardSection
            
            DetailView(header: "Сумма снятия", value: operation.operation.amount.description + ",00 ₽")
            DetailView(header: "Комиссия", value: operation.commission.description + ",00 ₽")
            DetailView(header: "Номер банкомата", value: "12584")
            DetailView(header: "Адрес", value: "г. Москва, наб. Космодамианская, д. 52")
            
            CommonViews.withdrawalTroublesHotline
                .padding(.bottom, 36)
            
            Button {
                let request = WithdrawalConfirmationRequest(orderId: operation.operation.orderId)
                dataModel.confirmOperation(confirmRequest: request, sessionData: sessionData)
            } label: {
                switch dataModel.status {
                case .initializing:
                    Text("Подтвердить")
                        .font(.system(size: 16))
                        .padding([.top, .bottom], 8)
                        .frame(maxWidth: .infinity)
                case .loading:
                    ProgressView()
                default:
                    EmptyView()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 24)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                CommonViews.navigationClose
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)
                
                withdrawalDetails
                    .navigationDestination(isPresented: $dataModel.operationIsConfirmed) {
                        EmptyView()
                    }
            }
            .padding([.leading, .trailing], 16)
            .navigationBarBackButtonHidden(true)
        }
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

struct WithdrawalConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawalConfirmView(
            sessionData: TestData.sessionData,
            operation: TestData.withdrawOperationWithCommission
        )
    }
}
