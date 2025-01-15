
import SwiftUI

struct InfoView: View {
    @State var animateButton: Bool = false
    @State var gradientColors: [Color] = [.blue, .init(red: 0, green: 0.7, blue: 1)]
    let smallHeight = UIScreen.main.bounds.height / 6
    let smallWidth = UIScreen.main.bounds.width - 100
    let bigHeight = UIScreen.main.bounds.height / 5
    let bigWidth = UIScreen.main.bounds.width - 70
    @State private var favGroup: String = UserDefaults.standard.string(forKey: "favGroup") ?? "101.1"
    private var groups = ["101.1","101.2","102.1","102.2","201.1","201.2","202","301.1","301.2","301.3","302","401.1","401.2","402.1","402.2"]
    @State var scale: CGFloat = 1
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(LinearGradient(colors: [.blue,.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            VStack{
                Form{
                    Picker(selection: $favGroup) {
                        ForEach(groups, id: \.self){ i in
                            Text(i)
                        }
                    } label: {
                        Text("Выберете группу по-умолачнию")
                    }
                    .pickerStyle(.menu)
                    .onChange(of: favGroup) {
                        UserDefaults.standard.set(favGroup, forKey: "favGroup")
                    }
                }
                .scrollContentBackground(.hidden)
                Image("au_gold")
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 10)
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
                            .blur(radius: 0.5)
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 6)
                            .foregroundStyle(LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                            .shadow(radius: 5)
    //                        .border(Color.black, width: 1)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .blur(radius: 0.5)
                            
                        HStack{
                            Image("telegram")
                                .resizable(resizingMode: .stretch)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: smallWidth / 6, height: smallHeight / 3)
                                .scaledToFit()
                                
                            Text("Telegram")
                                .foregroundStyle(.black)
                                .font(.custom("Roboto-Black", size: 30))
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
            .backgroundStyle(.black)
            .transition(.blurReplace)
            .padding()
        }
    }
}

#Preview {
    InfoView()
}
