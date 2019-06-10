import Foundation

struct MovieReleaseDateFormat: Hashable, Codable {
    let date: Date


    enum Error:  Swift.Error {
        case parsingError(String)
    }

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // "2017-10-25"
        return formatter
    }()

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let date = MovieReleaseDateFormat.formatter.date(from: rawValue) else {
            throw Error.parsingError(
                "\(rawValue) doesn't match the format \(MovieReleaseDateFormat.formatter.dateFormat ?? "") "
            )
        }
        self.date = date
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(MovieReleaseDateFormat.formatter.string(from: date))
    }
}
