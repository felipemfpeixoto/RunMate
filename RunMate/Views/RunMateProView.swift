import SwiftUI


struct RunMateProView: View {
    
    var store: Store = Store()
    @State var navigate: Bool = false
    @Binding var isEditing: Bool
    var body: some View {
        ZStack {
            Color(.blackBlue).ignoresSafeArea()
            VStack(spacing: 0) {
                VStack {
                    Spacer()
                    Text("RunMatePRO")
                        .font(Font.custom("Poppins-SemiBold", size: 32))
                        .foregroundStyle(Color.turquoiseGreen)
                        .padding(.top, 50)
                        .padding(.bottom, 10)
                    
                    Text("Para continuar aprimorando sua performance adquira o plano PRO.")
                        .font(Font.custom("Poppins-Medium", size: 18))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                    
                    
                    Image("BonequinhosCorrendo")
                }
                .padding(.bottom, 30)
                
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.oceanBlue)
                        .frame(height: 500)
                    
                    
                    VStack(spacing: 0) {
                        VStack {
                            
                            Text("RunMate PRO")
                                .font(Font.custom("Poppins-SemiBold", size: 22))
                                .foregroundStyle(Color.white)
                            
                            
                            Text("R$4.99")
                                .font(Font.custom("Poppins-SemiBold", size: 32))
                                .foregroundStyle(Color.turquoiseGreen)
                            
                            
                        } .padding(.bottom, 40)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundStyle(Color.turquoiseGreen)
                                    .font(.system(size: 25))
                                
                                
                                Text("Desbloqueie todas as semanas de treinamento")
                                    .font(Font.custom("Poppins-Medium", size: 18))
                                    .foregroundStyle(Color.white)
                                
                            }
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundStyle(Color.turquoiseGreen)
                                    .font(.system(size: 25))
                                
                                Text("Tenha acesso ao monitoramento de treinos")
                                    .font(Font.custom("Poppins-Medium", size: 18))
                                    .foregroundStyle(Color.white)
                                
                            }
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundStyle(Color.turquoiseGreen)
                                    .font(.system(size: 25))
                                
                                Text("Desbrave o RoadMap e tenha acesso a preview dos treinos")
                                    .font(Font.custom("Poppins-Medium", size: 18))
                                    .foregroundStyle(Color.white)
                                
                                
                            }
                        }
                        .padding(.bottom, 25)
                        
                        Button(action: {
                            Task {
                                if let product = store.products.first {
                                    if let transaction = try await store.purchase(product){
                                        dao.isPurchased = true
                                        dao.isBlocked = false
                                    }
                                }
                                
                            }
                        }, label: {
                            Text("COMPRAR PLANO PRO")
                                .foregroundColor(.blackBlue)
                                .frame(maxWidth: .infinity)
                                .font(Font.custom("Poppins-SemiBold", size: 20))
                                .padding(.vertical, 16)
                                .background(Color.turquoiseGreen)
                            
                        })
                        .cornerRadius(18)
                        .padding(.top, 30)
                        .padding(.horizontal, 40)
                    }
                    .padding(20)
                    
                    
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onChange(of: dao.isPurchased){
            if dao.isPurchased{
                navigate = true
            }
        }
        .background(
            NavigationLink(destination: SemanaView(isEditing: $isEditing), isActive: $navigate) {
                EmptyView()
            }
        )
    }
}

#Preview {
    RunMateProView( isEditing: .constant(false))
}
