import SwiftUI

struct WithdrawErrorView: View {
    
    private var headerSection: some View {
        Group {
            Image("errorIcon")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundColor(.red)
                .padding([.top, .bottom], 40)
            
            Text("Невозможно снять наличные")
                .font(.system(size: 22))
                .fontWeight(.bold)
                .padding(.bottom, 8)
            
            Text("Позвоните в банк, чтобы узнать подробнее")
                .font(.system(size: 16))
                .foregroundColor(.secondary)
                .padding(.bottom, 48)
        }
    }
    
    private var whatsNextSection: some View {
        Group {
            Text("Что делать дальше?")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .padding(.top, 24)
                .padding(.bottom, 8)
            
            Text("Пожалуйста, обратитесь в банк по телефону\n8 800 100-24-24 за подробной информацией.")
                .font(.system(size: 16))
                .padding(16)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Colors.lightGray)
                .padding(16)
        }
    }
    
    private var callUsItem: some View {
        Button {
            UIApplication.shared.open(URL(string: "tel://88001002424")!)
        } label: {
            HStack(alignment: .center) {
                ZStack(alignment: .center) {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Colors.lightGray)
                    
                    Image("callIcon")
                        .resizable(capInsets: EdgeInsets())
                        .frame(width: 20, height: 20)
                }
                .padding(.trailing, 12)
                
                Text("Позвонить в банк")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
            }
            .padding([.leading, .trailing], 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var doneButton: some View {
        NavigationLink(destination: OperationChooseView()) {
            Text("Готово")
                .font(.system(size: 16))
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 8)
        }
        .buttonStyle(.borderedProminent)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding([.leading, .trailing], 16)
        .padding(.bottom, 24)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                headerSection
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundColor(.white)
                    
                    VStack {
                        whatsNextSection
                        
                        callUsItem
                        
                        doneButton
                    }
                }
                
            }
            .background(Colors.bgLightGray)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct WithdrawErrorView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawErrorView()
    }
}
