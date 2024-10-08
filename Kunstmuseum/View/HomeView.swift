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
            
            Image("placeholder")
                .resizable()
                .frame(width: .infinity, height: 700)
                .clipShape(.rect(cornerRadius: 50))
                .blur(radius: 0).shadow(color: .purple,radius: 15)
                .opacity(0.9)
                .padding(.vertical)
            
            Image("placeholder")
                .resizable()
                .frame(width: 380, height: 380)
                .rotationEffect(Angle(degrees: 10))
                .blur(radius: 2)
                .blendMode(.hardLight)
                
            Image("placeholder")
                .resizable()
                .frame(width: 380, height: 380)
                .rotationEffect(Angle(degrees: 30))
                .blur(radius: 1)
                .blendMode(.darken)

            Text("KM")
                .font(.system(size: 190)).bold()
                .foregroundStyle(Color(hue: 1.0, saturation: 0.0, brightness: 1.0))
                .shadow(color: .purple, radius: 6)
                .opacity(0.9)
                .blendMode(.exclusion)
            
            Text("KunstMuseum")
                .font(.system(size: 55)).bold()
                .foregroundStyle(Color(hue: 1.0, saturation: 0.0, brightness: 1.0))
                .shadow(color: .purple, radius: 6)
                .opacity(0.99)
                .blendMode(.exclusion)
        }
        Spacer()
    }
}

#Preview {
    HomeView()
}
