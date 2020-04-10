import SwiftUI
import Combine


// TODO:(DEVELOPER): Change to a proper image loader
final class ImageLoader: ObservableObject {
    @Published var image: UIImage
    
    private(set) var url: URL? {
        didSet {
            if let url = url {
                load(url)
            }
        }
    }
    
    private var task: URLSessionTask?

    init(url: URL?) {
        self.url = url
        self.image = UIImage() //placeholder
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
                    self?.image = image
                }
            }
        }

        task?.resume()
    }
    
    deinit {
        task?.cancel()
    }
}
