import SwiftUI
import Combine


// TODO:(DEVELOPER): Change to a proper image loader
final class ImageLoader: BindableObject {

    let didChange = PassthroughSubject<UIImage, Never>()
    private(set) var url: URL? {
        didSet {
            if let url = url {
                load(url)
            }
        }
    }

    var hasImage: Bool { _image != nil }
    var image: UIImage { _image ?? _placeholder}

    var _placeholder = UIImage()

    var _image: UIImage? {
        didSet { didChange.send(_image ?? _placeholder) }
    }

    deinit {
        task?.cancel()
    }
    var task: URLSessionTask?

    init(url: URL?) {
        self.url = url
        if let url = url { load(url) }
    }

    private func load(_ url: URL) {
        task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            if let error = error {
                print("Finished loading \(error)")
            }
            guard let data = data, error == nil else { return }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?._image = image
                }

            }
        }

        task?.resume()

    }
}
