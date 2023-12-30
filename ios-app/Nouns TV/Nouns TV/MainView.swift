//
//  MainView.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//

import SwiftUI

struct MainView: View {
    @State private var showIntro: Bool = true
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                HeaderView()
                VideoHomeView()
                
            }
        }
    }
}
