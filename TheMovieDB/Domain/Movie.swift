import SwiftUI

struct Movie: Hashable, Identifiable {
    let id: Int
    let poster: URL?
    let name: String
    let released: MovieReleaseDateFormat
    let overview: String
}

extension Movie: Codable {

    enum CodingKeys: String, CodingKey
    {
        case id
        case poster = "poster_path"
        case name = "title"
        case released = "release_date"
        case overview
    }
}
