import SwiftUI


struct OperationChooseView: View {
    let sessionData = SessionData(uncId: "1234567", mdmId: "6543210", atmId: "6665551")
    
    var body: some View {
        NavigationView {
            VStack {
                OperationChooseHeaderView()
                
                OperationTypeView(sessionData: sessionData)
                
                OperationChooseFooterView()
                
                Spacer()
            }
            .padding(16)
        }
    }
}

struct OperationTypeView: View {
    let sessionData: SessionData
    
    
    var body: some View {
        HStack {
            NavigationLink(destination: WithdrawalView(sessionData: sessionData)) {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Colors.lightGray)
                    
                    VStack(alignment: .leading) {
                        ZStack(alignment: .center) {
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                            
                            Image("withdrawIcon")
                                .resizable(capInsets: EdgeInsets())
                                .frame(width: 30, height: 30)
                        }
                        .padding(.bottom, 8)
                        
                        Text("Снять\nналичные")
                            .font(.headline)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                        
                    }
                    .padding(16)
                }
            }
            .buttonStyle(.plain)
            
            NavigationLink(destination: DepositView()) {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Colors.lightGray)
                    
                    VStack(alignment: .leading) {
                        ZStack(alignment: .center) {
                            Circle()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                            
                            Image("depositIcon")
                                .resizable(capInsets: EdgeInsets())
                                .frame(width: 30, height: 30)
                        }
                        .padding(.bottom, 8)
                        
                        Text("Внести\nналичные")
                            .font(.headline)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                    }
                    .padding(16)
                }
            }
            .buttonStyle(.plain)
        }
        .frame(height: 160)
        .padding(.bottom, 24)
    }
}

struct OperationChooseHeaderView: View {
    var body: some View {
        Text("Снятие и внесение наличных")
            .font(.headline)
            .padding(.bottom, 24)
    }
}

struct OperationChooseFooterView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("starIcon")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text("Снимайте до 40 000 ₽ в месяц")
                        .font(.headline)
                    Text("Сейчас вам доступно 5 000 ₽ для снятия")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.bottom, 8)
            
            HStack {
                Image("starIcon")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text("Вносите до 60 000 ₽")
                        .font(.headline)
                    Text("Сейчас вам доступно 8 000 ₽ для внесения")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.bottom, 8)
        }
        
        Text("Если у вас возникли проблемы со снятием или внесением наличных, звоните по номеру: [8 800 100-24-24](phone:88001002424)")
    }
}

struct OperationChooseView_Previews: PreviewProvider {
    static var previews: some View {
        OperationChooseView()
    }
}
