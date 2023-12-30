//
//  VideoHomeView.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//

import SwiftUI
import AVKit

struct VideoHomeView: View {
    @ObservedObject var viewModel = VideoViewModel()

    var contentShorts: [(title: String, thumbnailLink: String, videoLink: String, youtubeLink: String, creatorName: String)] {
        viewModel.shortContent.map { video in
            (title: video.title, thumbnailLink: video.thumbnailLink, videoLink: video.videoLink,  youtubeLink: video.youtubeLink, creatorName: video.creatorName)
        }
    }

    var contentSeries: [(title: String, thumbnailLink: String, videoLink: String, youtubeLink: String, creatorName: String)] {
        viewModel.seriesContent.map { video in
            (title: video.title, thumbnailLink: video.thumbnailLink, videoLink: video.videoLink, youtubeLink: video.youtubeLink, creatorName: video.creatorName)
        }
    }
    
    var contentDoc: [(title: String, thumbnailLink: String, videoLink: String, youtubeLink: String, creatorName: String)] {
        viewModel.docContent.map { video in
            (title: video.title, thumbnailLink: video.thumbnailLink, videoLink: video.videoLink, youtubeLink: video.youtubeLink, creatorName: video.creatorName)
        }
    }

    @State private var localImages: [String: Image] = [:]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                topPreview
                section1(title: "Shorts: Season 1", content: contentShorts)
                section2(title: "Series: Rise of Blus", content: contentSeries)
            }
        }
        .onAppear {
            viewModel.downloadLocalData()
        }
    }

    var topPreview: some View {
        VStack(alignment: .leading) {
            LazyHGrid(rows: [GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 0)], spacing: 0) {
                let shuffledContent = contentShorts.dropLast().shuffled()
                ForEach(shuffledContent.prefix(1), id: \.title) { video in
                    CardPreview(
                        title: video.title,
                        thumbnailLink: video.thumbnailLink,
                        videoLink: video.videoLink,
                        youtubeLink: video.youtubeLink,
                        creatorName: video.creatorName
                    )
                    .padding(0)
                }
            }
        }
    }

    func section1(title: String, content: [(title: String, thumbnailLink: String, videoLink: String, youtubeLink: String, creatorName: String)]) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.title)
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(), GridItem()]) {
                    ForEach(content, id: \.title) { video in
                        CardViewH(
                            title: video.title,
                            thumbnailLink: video.thumbnailLink,
                            videoLink: video.videoLink,
                            youtubeLink: video.youtubeLink,
                            creatorName: video.creatorName
                        )
                    }
                }
            }
        }
        .padding()
    }
    
    func section2(title: String, content: [(title: String, thumbnailLink: String, videoLink: String, youtubeLink: String, creatorName: String)]) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.title)
            }
            ScrollView(.horizontal) {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(content, id: \.title) { video in
                        CardViewV(
                            title: video.title,
                            thumbnailLink: video.thumbnailLink,
                            videoLink: video.videoLink,
                            youtubeLink: video.youtubeLink,
                            creatorName: video.creatorName
                        )
                    }
                }
            }
        }
        .padding()
    }
    
    func section3(title: String, content: [(title: String, thumbnailLink: String, videoLink: String, youtubeLink: String, creatorName: String)]) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.title)
            }
            ScrollView(.horizontal) {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(content, id: \.title) { video in
                        CardViewY(
                            title: video.title,
                            thumbnailLink: video.thumbnailLink,
                            videoLink: video.youtubeLink,
                            youtubeLink: video.youtubeLink,
                            creatorName: video.creatorName
                        )
                    }
                }
            }
        }
        .padding()
    }
}

struct VideoHomeView_Previews: PreviewProvider {
    static var previews: some View {
        VideoHomeView()
    }
}
