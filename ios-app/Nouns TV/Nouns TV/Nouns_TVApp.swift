//
//  Nouns_TVApp.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//

import SwiftUI

@main
struct NounsTVApp: App {
    @State private var isLoading = true

    var body: some Scene {
        WindowGroup {
            if isLoading {
                IntroView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                isLoading = false
                            }
                        }
                    }
            } else {
                MainView()
            }
        }
    }
}
