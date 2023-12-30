//
//  ImageUtility.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//

import Foundation
import UIKit

class ImageUtility {
    static func fetchAndStoreImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        ImageFetcher().fetchImage(for: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    saveImageToDisk(image: image, url: url)
                    completion(image)
                }
            case .failure(let error):
                print("Error fetching image: \(error)")
                completion(nil)
            }
        }
    }
    
    static func loadImageFromDisk(urlString: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let imageURL = documentsDirectory?.appendingPathComponent(urlString)
        
        if let imageURL = imageURL,
           let imageData = try? Data(contentsOf: imageURL),
           let image = UIImage(data: imageData) {
            return image
        } else {
            return nil
        }
    }
    
    static func saveImageToDisk(image: UIImage, url: URL) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let imageURL = documentsDirectory.appendingPathComponent(url.lastPathComponent)
        
        if let imageData = image.pngData() {
            try? imageData.write(to: imageURL)
        }
    }
}
