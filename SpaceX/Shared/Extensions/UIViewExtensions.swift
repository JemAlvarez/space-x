//

import UIKit

extension UIView {
    // generate attributed string with icon
    func makeLabel(title: String, text: String, icon: String) -> NSAttributedString {
        let fullString = NSMutableAttributedString()
        fullString.append(NSAttributedString(string: icon))
        fullString.append(
            NSAttributedString(
                string: " \(title): ",
                attributes: [
                    .font: UIFontMetrics(forTextStyle: .body)
                        .scaledFont(for:
                                .systemFont(ofSize: .fontBody, weight: .semibold)
                        )
                ]
            )
        )
        fullString.append(NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.secondaryLabel]))

        return fullString
    }

    // downsample image view
    func downsample(with data: Data, to size: CGSize, scale: CGFloat = UIScreen.main.scale, completion: @escaping (UIImage?) -> Void) {
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
        var cachedImages: [String: Data] = UserDefaults.standard.object(forKey: UserDefaults.Keys.cachedImages.rawValue) as? [String: Data] ?? [:]
        let foundImage = cachedImages.first(where: { $0.key == imageUrl })

        if let foundImage = foundImage {
            // used cached image
            completion(foundImage.value)
        } else {
            // download image and cache
            DispatchQueue.global().async {
                if let url = imageUrl {
                    let data = url.getURLData()

                    if let data = data {
                        cachedImages[url] = data
                        UserDefaults.standard.set(cachedImages, forKey: UserDefaults.Keys.cachedImages.rawValue)

                        DispatchQueue.main.async {
                            completion(data)
                        }
                    }
                }
            }
        }
    }
}
