//
//  VideoViewModel.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//


import Foundation

class VideoViewModel: ObservableObject {
    @Published var shortContent: [VideoModel] = []
    @Published var seriesContent: [VideoModel] = []
    @Published var docContent: [VideoModel] = []

    init() {
        downloadLocalData()
        downloadJSONFiles()
    }

    func downloadJSONFiles() {
        let shortFilmsJSONURL = URL(string: "https://raw.githubusercontent.com/fiveoceans-dev/NounsTV/main/content-list/nouns-short-films.json")!
        let seriesFilmsJSONURL = URL(string: "https://raw.githubusercontent.com/fiveoceans-dev/NounsTV/main/content-list/nouns-series-films.json")!
        let docFilmsJSONURL = URL(string: "https://raw.githubusercontent.com/fiveoceans-dev/NounsTV/main/content-list/nouns-doc-films.json")!

        let shortFilmsDownloader = JsonDownloader(jsonURL: shortFilmsJSONURL, localFileName: "nouns-short-films.json")
        shortFilmsDownloader.downloadJSON { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedContent = try decoder.decode([VideoModel].self, from: data)
                    DispatchQueue.main.async {
                        self.shortContent = decodedContent
                    }
                    print("Short Films JSON Content: \(self.shortContent)")
                } catch {
                    print("Error decoding Short Films JSON: \(error)")
                }

            case .failure(let error):
                print("Error downloading Short Films JSON: \(error)")
            }
        }

        let seriesFilmsDownloader = JsonDownloader(jsonURL: seriesFilmsJSONURL, localFileName: "nouns-series-films.json")
        seriesFilmsDownloader.downloadJSON { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedContent = try decoder.decode([VideoModel].self, from: data)
                    DispatchQueue.main.async {
                        self.seriesContent = decodedContent
                    }
                    print("Series Films JSON Content: \(self.seriesContent)")
                } catch {
                    print("Error decoding Series Films JSON: \(error)")
                }

            case .failure(let error):
                print("Error downloading Series Films JSON: \(error)")
            }
        }
        
        let docFilmsDownloader = JsonDownloader(jsonURL: docFilmsJSONURL, localFileName: "nouns-doc-films.json")
        docFilmsDownloader.downloadJSON { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedContent = try decoder.decode([VideoModel].self, from: data)
                    DispatchQueue.main.async {
                        self.docContent = decodedContent
                    }
                    print("Doc Films JSON Content: \(self.docContent)")
                } catch {
                    print("Error decoding Doc Films JSON: \(error)")
                }

            case .failure(let error):
                print("Error downloading Doc Films JSON: \(error)")
            }
        }
    }

    func downloadLocalData() {
        for video in shortContent + seriesContent + docContent {
            if !imageExistsLocally(for: video.title) {
                downloadImage(for: video)
            }
        }
    }

    func imageExistsLocally(for title: String) -> Bool {

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imageFileURL = documentsDirectory.appendingPathComponent("\(title).jpg")
        return FileManager.default.fileExists(atPath: imageFileURL.path)
    }

    func downloadImage(for video: VideoModel) {

        if let thumbnailURL = URL(string: video.thumbnailLink) {
            URLSession.shared.dataTask(with: thumbnailURL) { data, _, error in
                if let data = data {
                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let imageFileURL = documentsDirectory.appendingPathComponent("\(video.title).jpg")

                    do {
                        try data.write(to: imageFileURL)
                    } catch {
                        print("Error saving image locally: \(error)")
                    }
                }
            }.resume()
        }
    }
}
