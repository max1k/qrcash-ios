import Foundation
import SwiftUI


struct DepositParentView: View {
    let sessionData: SessionData
    
    @StateObject
    private var dataModel: CardListDataModel = CardListDataModel()
    
    var body: some View {
        Group {
            switch dataModel.status {
            case .done:
                DepositView(sessionData: sessionData, cardListDataModel: dataModel)
            case .loading, .initializing:
                ProgressView()
            default:
                OperationErrorView(operationType: .deposit)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            dataModel.getCards(sessionData: sessionData)
        }
    }
}

struct DepositView: View {
    let sessionData: SessionData
    let cardListDataModel: CardListDataModel
    
    @StateObject
    private var creationDataModel = OperationCreationDataModel()
    
    
    private var header: some View {
        Text("Внесение наличных")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 22))
            .padding([.top, .bottom], 20)
            .fontWeight(.bold)
    }
    
    private var continueButton: some View {
        Button(action: handleContinueClick) {
            switch creationDataModel.status {
            case .initializing:
                Text("Продолжить")
                    .font(.system(size: 16))
                    .padding([.top, .bottom], 8)
                    .frame(maxWidth: .infinity)
            case .loading:
                ProgressView()
                    .padding([.top, .bottom], 8)
                    .frame(maxWidth: .infinity)
            default:
                EmptyView()
            }
        }
        .buttonStyle(.borderedProminent)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    var body: some View {
            VStack(alignment: .leading) {
                CommonViews.navigationBack
                header
                
                CardSelectView(operationType: .deposit, dataModel: cardListDataModel)
                
                CommonViews.withdrawalTroublesHotline
                continueButton
            }
            .padding(16)
            .navigationDestination(isPresented: $creationDataModel.operationIsCreated) {
                if let card = cardListDataModel.selectedCard, let orderId = creationDataModel.orderId {
                    OperationCompletedView(
                        operation: OperationWithCommission(
                            operation: Operation(
                                card: card,
                                type: .deposit,
                                orderId: orderId,
                                amount: 300
                            ),
                            commission: 0,
                            describedType: .deposit
                        )
                    )
                }
            }
            .navigationDestination(isPresented: $creationDataModel.operationFailed) {
                OperationErrorView(operationType: .deposit)
            }
    }
    
    private func handleContinueClick() {
        if let card = cardListDataModel.selectedCard {
            let request = DepositOperationRequest(
                atmId: sessionData.atmId,
                publicId: card.publicId
            )
            creationDataModel.createOperation(request: request, sessionData: sessionData)
        }
    }
}

struct DepositView_Previews: PreviewProvider {
    static var previews: some View {
        DepositView(sessionData: TestData.sessionData, cardListDataModel: CardListDataModel())
    }
}
