import SwiftUI

struct MovieDetail: ConnectedView {
    let id: Movie.ID
    
    struct Props {
        let poster: URL?
        let name: String
        let released: String
        let overview: String

        let isFavorite: Bool
        let toggleFavorite: () -> Void
    }


    // MARK: - Map State To Props -

    /// Map State To Props
    /// - Parameter state: current app state
    /// - Parameter dispatch: closure for dispatching an Action
    func map(state: AppState, dispatch: @escaping (Action) -> Void) -> Props {
        guard let movie = state.movieByID[id] else {
            fatalError("Id not found")
        }

        return Props(
            poster: movie.poster,
            name: movie.name,
            released: String(Calendar.current.component(.year, from: movie.released.date)),
            overview: movie.overview,
            isFavorite: state.favoriteMovies.contains(movie.id),
            toggleFavorite: { dispatch(Actions.ToggleMovieFavorite(id: self.id)) }
        )
    }

    // MARK: - Render -
    
    static func body(props: Props) -> some View {
        ScrollView {
            VStack {
                RemoteImage(url: props.poster)
                Text(props.overview)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
        }.navigationBarTitle(Text(props.name), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: props.toggleFavorite) {
                if props.isFavorite {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                    } else {
                        Image(systemName: "star")
                            .foregroundColor(Color.gray)
                    }
                })
        }
}
