//
//  IntroView.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//

import SwiftUI

struct IntroView: View {
    @State private var currentBackgroundIndex: Int = 1
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image("introBackground\(currentBackgroundIndex)")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            Color.red
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)

        }
        .onReceive(timer) { _ in
            currentBackgroundIndex = (currentBackgroundIndex % 10) + 1 //
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
