//

import UIKit

class ImageCacher {
    static let shared = ImageCacher()
    let cache = NSCache<NSString, CachedImage>()

    // downsample image view
    static func downsample(with data: Data, to size: CGSize, scale: CGFloat = UIScreen.main.scale, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imgSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
            guard let imgSource = CGImageSourceCreateWithData(data as CFData, imgSourceOptions) else { return }

            let dimensions = max(size.width, size.height) * scale

            let downsampleOptions = [
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceShouldCacheImmediately: true,
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceThumbnailMaxPixelSize: dimensions
            ] as CFDictionary

            guard let downsampledImg = CGImageSourceCreateThumbnailAtIndex(imgSource, 0, downsampleOptions) else { return }

            completion(UIImage(cgImage: downsampledImg))
        }
    }

    // get cached image data
    func getCachedImageData(imageUrl: String?, completion: @escaping (Data) -> Void) {

        if let foundImage = cache.object(forKey: NSString(string: imageUrl ?? "-")) {
            // used cached image
            print("USED CACHE")
            completion(foundImage.data)
        } else {
            // download image and cache
            DispatchQueue.global().async { [weak self] in
                print("TRYING TO FETCH")
                if let url = imageUrl {
                    let data = url.getURLData()

                    if let data = data {
                        self?.cache.setObject(CachedImage(data: data), forKey: NSString(string: url))
                        print("FETCHED & CACHED")

                        DispatchQueue.main.async {
                            completion(data)
                        }
                    }
                }
            }
        }
    }
}

class CachedImage {
    let data: Data

    init(data: Data) {
        self.data = data
    }
}
