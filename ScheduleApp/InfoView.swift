
import SwiftUI

struct InfoView: View {
    @State var animateButton: Bool = false
    @State var gradientColors: [Color] = [.blue, .purple]
    var body: some View {
        VStack{
            Image("au_gold")
            Text("Если у вас возникли вопросы или предложения, то обращайтесь в телеграм!")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            Link(destination: URL(string: "https://t.me/SPBAU_Help_Bot")!){
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: UIScreen.main.bounds.width - 70, height: UIScreen.main.bounds.height / 5)
                        .foregroundStyle(LinearGradient(colors: gradientColors, startPoint: .bottomTrailing, endPoint: .topLeading))
                        .shadow(radius: 5)
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 6)
                        .foregroundStyle(LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                        .shadow(radius: 5)
                        .border(Color.black, width: 1)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        
                    HStack{
                        Text("Telegram")
                            .foregroundStyle(.black)
                            .font(.custom("fear No more", size: 20))
                    }
    //                        Label("Telegram", image: "")
    //                            .font(.custom("Fear No More", size: 15))
                }
//                .onTapGesture {
//                    gradientColors.swapAt(0, 1)
//                    animateButton.toggle()
//                    DispatchQueue.global().asyncAfter(deadline: .now() + 0.2, execute:{
//                        gradientColors.swapAt(0, 1)
//                        animateButton.toggle()
//                    })
//                }
//                .animation(.snappy, value: animateButton)
//                .scaleEffect(animateButton ? 0.9 : 1)
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    InfoView()
}
