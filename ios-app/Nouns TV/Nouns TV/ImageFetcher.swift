//
//  ImageFetcher.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//

import SwiftUI

class ImageFetcher: ObservableObject {
    @Published var image: UIImage?

    func fetchImage(for url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(ImageFetcherError.invalidImageData))
                return
            }

            completion(.success(image))
        }.resume()
    }
}

enum ImageFetcherError: Error {
    case invalidURL
    case invalidImageData
}
