//
//  JsonDownloader.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//

import Foundation

class JsonDownloader {
    private let jsonURL: URL
    private let localFileName: String

    init(jsonURL: URL, localFileName: String) {
        self.jsonURL = jsonURL
        self.localFileName = localFileName
    }

    func downloadJSON(completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: jsonURL) { (data, response, error) in
            if let error = error {
                print("Network Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            if let data = data {
                // Save the JSON locally before completing
                self.saveJSONLocally(data: data)
                completion(.success(data))
            }
        }
        task.resume()
    }

    private func saveJSONLocally(data: Data) {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        let localFileURL = documentsDirectoryURL.appendingPathComponent(localFileName)

        do {
            try data.write(to: localFileURL, options: .atomic)
        } catch {
            print("Error saving JSON locally: \(error)")
        }
    }
}
