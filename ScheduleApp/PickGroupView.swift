import SwiftUI

struct PickGroupView: View {
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Text("Выберете день и группу 🧑‍🏫")
                    .foregroundStyle(.black)
                    .font(.custom("Roboto-Medium", size: 30))
                    
                Spacer()
            }
            Spacer()
        }
        .padding()
        .background(.blue, in: .rect(cornerRadius: 10))
        .transition(.scale)
    }
}

