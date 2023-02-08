import SwiftUI

struct ConfirmationErrorView: View {
    
    private var doneButton: some View {
        NavigationLink(destination: OperationChooseView()) {
            Text("Понятно")
                .font(.system(size: 16))
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 8)
        }
        .buttonStyle(.borderedProminent)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, 24)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image("errorIcon")
                .resizable()
                .frame(width: 64, height: 64)
                .padding(.top, 128)
                .padding(.bottom, 40)
                .foregroundColor(.black)
            
            Text("Не удалось подтвердить операцию")
                .font(.system(size: 22))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
            Text("Вы ввели код подтверждения неверно несколько раз. Попробуйте повторить операцию еще раз. Если у вас возникли проблемы со снятием наличных, звоните по номеру: [8 800 100-24-24](tel://88001002424)")
                .multilineTextAlignment(.center)
            
            doneButton
        }
        .padding([.leading, .trailing], 16)
        .navigationBarBackButtonHidden(true)
    }
}

struct ConfirmationErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationErrorView()
    }
}
