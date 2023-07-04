//
//  ImageDownloader.swift
//  domashkaRam2
//
//  Created by Erzhan Tokochev on 7/1/23.
//

import UIKit

enum ImageDownloader {
    static func downloadImage(with url: String) -> UIImage? {
        let url = URL(string: url)
        var imageData: Data?
        DispatchQueue.global(qos: .userInitiated).async {
            imageData = try? Data(contentsOf: url!)
        }
        guard let imageData else {
            return nil
        }
        return UIImage(data: imageData)
    }
}
