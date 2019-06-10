import Combine
import SwiftUI

final class ImageLoader {

    private(set) var image = UIImage()


    init(url: URL?) {
        if let url = url {
            load(url)
        }
    }

    func load(_ url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            if let image = UIImage(data: data) {
                self.image = image
            }
        }.resume()

    }
}

struct RemoteImage: View {
    @ObjectBinding var loader: ImageLoader

    init(url: URL) {
        loader = ImageLoader(url: url)
    }

    var body: some View {
        if loader.hasImage {
            Image(loader.image)
        } else {
            Text("Loading")
        }
    }
}

