//
//  HeaderView.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            ZStack {
                HStack(alignment: .top) {
                    Text("Nouns+TV")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(15)
            }
        }
    }
    
}

#Preview {
    HeaderView()
}
