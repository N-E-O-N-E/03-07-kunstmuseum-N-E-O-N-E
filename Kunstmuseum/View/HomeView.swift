//
//  About.swift
//  Kunstmuseum
//
//  Created by Markus Wirtz on 09.10.24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ZStack(alignment:.center) {
            
            Image("museum")
                .resizable()
                .scaledToFill()
                .frame(width: .infinity, height: 760)
                .ignoresSafeArea()
                .shadow(radius: 20)

            VStack {
                Image("placeholder")
                    .resizable()
                    .frame(width: 210, height: 135)
                    .border(.black)
                    .shadow(color: .gray, radius: 4)
                    
                Text("Kunstmuseum V1.0")
                    .font(.system(size: 12)).bold().fontDesign(.serif)
                    .foregroundStyle(Color(hue: 0.0, saturation: 0.0, brightness: 0.0))
                    .shadow(color: .white, radius: 10)
                    .opacity(0.9)
                    .padding(5)
            }.offset(x: 0, y: 0)
        }
        Spacer()
    }
}

#Preview {
    HomeView()
}
