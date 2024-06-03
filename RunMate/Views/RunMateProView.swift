import SwiftUI


struct RunMateProView: View {
    
    var store: Store = Store()
    @State var showSemana: Bool = false
    @Binding var isEditing: Bool
    @Binding var showPro: Bool
    @Environment(\.dismiss) var dismiss
    @State var preco: String = ""
    var body: some View {
        ZStack {
            Color(.blackBlue).ignoresSafeArea()
            VStack(spacing: 0) {
                VStack {
                    Spacer()
                    Text("RunMatePRO")
                        .font(Font.custom("Poppins-SemiBold", size: 32))
                        .foregroundStyle(Color.turquoiseGreen)
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                    
                    Text("Para continuar aprimorando sua performance adquira o plano PRO.")
                        .font(Font.custom("Poppins-Medium", size: 18))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 10)
                    
                    
                    Image("BonequinhosCorrendo")
                        .resizable()
                        .frame(width: 261.19, height: 80)
                }
                .padding(.bottom, 30)
                
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.oceanBlue)
                        .frame(height: 500)
        
                    VStack(spacing: 0) {
                            
                        VStack (spacing: -5){
                            Text("Valor promocional por tempo limitado!")
                                .font(Font.custom("Poppins-SemiBold", size: 19))
                                .foregroundStyle(Color.white)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 8)
                            
                            Text("R$4.90")
                                .font(Font.custom("Poppins-SemiBold", size: 32))
                                .foregroundStyle(Color.turquoiseGreen)
                            Text("R$9.90")
                                .font(Font.custom("Poppins-SemiBold", size: 22))
                                .foregroundStyle(Color.white).opacity(0.7)
                                .strikethrough()
                        }
                        .padding(.bottom, 20)
                    
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundStyle(Color.turquoiseGreen)
                                    .font(.system(size: 25))
                                
                                
                                Text("Desbloqueie todas as semanas de treinamento")
                                    .font(Font.custom("Poppins-Medium", size: 15))
                                    .foregroundStyle(Color.white)
                                
                            }
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundStyle(Color.turquoiseGreen)
                                    .font(.system(size: 25))
                                
                                Text("Tenha acesso ao monitoramento de treinos")
                                    .font(Font.custom("Poppins-Medium", size: 15))
                                    .foregroundStyle(Color.white)
                                
                            }
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundStyle(Color.turquoiseGreen)
                                    .font(.system(size: 25))
                                
                                Text("Desbrave o RoadMap e tenha acesso a preview dos treinos")
                                    .font(Font.custom("Poppins-Medium", size: 15))
                                    .foregroundStyle(Color.white)
                                
                                
                            }
                        }
                        
                        Button(action: {
                            Task {
                                if let product = store.products.first {
                                    if let transaction = try await store.purchase(product){
                                        dao.isPurchased = true
                                        dao.isBlocked = false
//                                        showPro = false
                                        dismiss()
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
                        
                        Button(action: {
                            Task{
                                await store.refreshPurchasedProducts()
                                if store.purchasedProducts.count > 0 {
                                    dao.isPurchased = true
                                    dao.isBlocked = false
//                                    showPro = false
                                    dismiss()
                                }
                            }
                        }, label: {
                            Text("Restaurar compras")
                        })
                        .padding(.top, 10)
                        .foregroundColor(.turquoiseGreen)
                        .font(Font.custom("Poppins-Medium", size: 15))
                    }
                    .padding(20)
                    
                    
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
//        .onChange(of: dao.isPurchased){
//            if dao.isPurchased{
//                showSemana = true
//            }
//        }
    }
}

#Preview {
    RunMateProView( isEditing: .constant(false), showPro: .constant(false))
}
