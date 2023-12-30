//
//  CardViewV.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//

import SwiftUI
import AVKit

struct CardViewV: View {
    var title = "Title"
    var thumbnailLink = "https://raw.githubusercontent.com/fiveoceans-dev/NounsTV/main/content-list/CommingSoon.jpg"
    var videoLink = "Video"
    var youtubeLink = "YouTube"
    var creatorName = "Creator"
    
    @State private var thumbnailImage: UIImage?

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                    .frame(width: 160, height: 90)
                    .overlay(
                        Group {
                            if let thumbnailImage = thumbnailImage {
                                Image(uiImage: thumbnailImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 160, height: 90)
                            } else {
                                Image(systemName: "photo")
                                    .foregroundColor(.white)
                            }
                        }
                    )
            }
            Text(title)
                .font(.system(size: 16))
                .frame(width: 160, height: 50, alignment: .top)
                .lineLimit(2)
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

struct CardViewV_Previews: PreviewProvider {
    static var previews: some View {
        CardViewV()
    }
}
