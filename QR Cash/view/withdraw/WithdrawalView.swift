import Foundation
import SwiftUI


struct WithdrawalParentView: View {
    let sessionData: SessionData
    
    @StateObject
    private var dataModel = CardListDataModel()
    
    var body: some View {
        Group {
            switch dataModel.status {
            case .done:
                WithdrawalView(sessionData: sessionData, dataModel: dataModel)
            case .loading, .initializing:
                ProgressView()
            default:
                OperationErrorView(operationType: .withdraw)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            dataModel.getCards(sessionData: sessionData)
        }
    }
}

struct WithdrawalView: View {
    let sessionData: SessionData
    let dataModel: CardListDataModel
    
    @State
    private var amount: Decimal?
    
    @State
    private var operationIsValid = false
    
    private var atmCodeViewLink: some View {
        operationIsValid
        ? AtmCodeParentView(
            sessionData: sessionData,
            card: dataModel.selectedCard!,
            amount: amount!,
            codeLength: Properties.atmCodeLength
        )
        : nil
    }
    
    private var header: some View {
        Text("Снятие наличных")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 22))
            .padding([.top, .bottom], 20)
            .fontWeight(.bold)
    }
    
    private var continueButton: some View {
        NavigationLink(destination: atmCodeViewLink) {
             Text("Продолжить")
                 .font(.system(size: 16))
                 .frame(maxWidth: .infinity)
                 .padding([.top, .bottom], 8)
         }
         .buttonStyle(.borderedProminent)
         .frame(maxHeight: .infinity, alignment: .bottom)
         .disabled(!operationIsValid)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            CommonViews.navigationBack
            header
            
            CardSelectView(operationType: .withdraw, dataModel: dataModel)
            AmountInputView(amountChangeListener: onAmountChange)
            
            CommonViews.withdrawalTroublesHotline
            continueButton
        }
        .padding(16)
    }
    
    private func onAmountChange(_ newValue: Decimal) {
        let availableAmount = dataModel.selectedCard?.balance ?? Decimal(0)
        let cardIsSelected = dataModel.selectedCard != nil
                        
        amount = newValue
        operationIsValid = cardIsSelected && newValue > 0 && newValue <= availableAmount
    }
}

struct WithdrawalView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawalView(sessionData: TestData.sessionData, dataModel: CardListDataModel())
    }
}
