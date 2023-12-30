//
//  CardPreview.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//

import SwiftUI
import AVKit

struct CardPreview: View {
    var title = "Title"
    var thumbnailLink = "https://raw.githubusercontent.com/fiveoceans-dev/NounsTV/main/content-list/CommingSoon.jpg"
    var videoLink = "https://ipfs.decentralized-content.com/ipfs/bafybeiakidy56cgjqbv3qoxtddwhazcyvdq7ixreivykf77s46f54pvga4"
    var youtubeLink = "https://www.youtube.com/watch?v=dticrpal5Zo"
    var creatorName = "Creator"

    
    @State private var thumbnailImage: UIImage?

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width * 9/16)
                    .overlay(
                        Group {
                            if let thumbnailImage = thumbnailImage {
                                Image(uiImage: thumbnailImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width * 9/16, alignment: .center)
                            } else {
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            }
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .opacity(0.5)
                                    .frame(width: 105, height: 105)
                                Image(systemName: "play.circle")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(Color.white)
                            }
                        }
                    )
            }
            VStack {
                Text(title)
                    .font(.system(size: 16))
                    .lineLimit(2)
                Text("By \(creatorName)")
                    .font(.system(size: 14))
                    .lineLimit(2)
            }
        }
        .onAppear {
            loadImageFromURL()
        }
        .onTapGesture {
            if let videoURL = URL(string: videoLink) {
                let avPlayer = AVPlayer(url: videoURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = avPlayer
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    if let window = windowScene.windows.first {
                        window.rootViewController?.present(playerViewController, animated: true, completion: {
                            avPlayer.play()
                        })
                    }
                }
            }
        }
    }
    
    private func loadImageFromURL() {
        if let url = URL(string: thumbnailLink) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    thumbnailImage = image
                }
            }.resume()
        }
    }
}

struct CardPreview_Previews: PreviewProvider {
    static var previews: some View {
        CardPreview()
    }
}
