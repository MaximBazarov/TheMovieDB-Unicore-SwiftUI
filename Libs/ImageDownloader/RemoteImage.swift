import SwiftUI

struct RemoteImage: View {
    @ObservedObject var loader: ImageLoader

    init(url: URL?) {
        loader = ImageLoader(url: url)
    }

    var body: some View {
        Image(uiImage: loader.image)
            .resizable()
            .scaledToFill()
    }
}
