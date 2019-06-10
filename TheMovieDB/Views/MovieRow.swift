import SwiftUI

struct MovieRow: ConnectedView {

    struct Props {
        let poster: URL?
        let name: String
        let released: String
        let overview: String
        let isFavorite: Bool
    }
    
    let id: Movie.ID
    
    func map(state: AppState, dispatch: @escaping (Action) -> Void) -> Props {
        guard let movie = state.movieByID[id] else {
            fatalError("Id not found")
        }
        
        return Props(
            poster: movie.poster,
            name: movie.name,
            released: String(Calendar.current.component(.year, from: movie.released.date)),
            overview: movie.overview,
            isFavorite: state.favoriteMovies.contains(movie.id)
        )
    }
    
    static func body(props: Props) -> some View {
        VStack {

            HStack {
                RemoteImage(url: props.poster)
                    .frame(width: 50)

                VStack(alignment: .leading) {
                    Text(verbatim: props.name)
                        .font(.headline)

                    Spacer()

                    Text(verbatim: props.released)
                        .font(.subheadline)
                }


                if props.isFavorite {
                    Image(systemName: "star.fill")
                        .imageScale(.medium)
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}
