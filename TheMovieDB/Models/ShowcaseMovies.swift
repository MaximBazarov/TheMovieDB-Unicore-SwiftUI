import Foundation


let moviesShowcaseData: [Movie] = load("moviesShowcaseData.json")

let showcaseMovies: [Movie] = moviesShowcaseData.compactMap { movie in

    func poster(_ poster: URL?) -> URL? {
        guard let poster = poster else { return nil }
        return URL(string: "http://image.tmdb.org/t/p/")!
            .appendingPathComponent("w780")
            .appendingPathComponent(poster.absoluteString)
    }

    return Movie(id: movie.id, poster: poster(movie.poster), name: movie.name, released: movie.released, overview: movie.overview)
}



func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
