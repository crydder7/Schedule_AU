//
//  LaunchScreenView.swift
//  ScheduleApp
//
//  Created by lonely. on 1/10/25.
//

import SwiftUI

struct LaunchScreenView: View {
    @State var show: Bool = false
    @State var scale: CGFloat = 1.1
    @State var isScale: Bool = false
    
    var body: some View {
        if show{
            TabsView()
        } else{
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(Color.colorLC)
                VStack{
                    Image("LC_PIC")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(contentMode: .fit)
                        
                }
            }
            .ignoresSafeArea(.all, edges: .all)
            .onAppear{
                withAnimation(.bouncy(duration: 0.5)) {
                    isScale.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        show.toggle()
                    }
                }
            }
            .transition(.move(edge: .top))
        }
    }
}

#Preview {
    LaunchScreenView()
}
