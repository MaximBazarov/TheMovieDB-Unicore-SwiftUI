import SwiftUI

struct MoviesList<Row: View, Details: View>: ConnectedView {
    let row: (Movie.ID) -> Row
    let details: (Movie.ID) -> Details
    
    struct Props<Row: View, Details: View> {
        let showFavoritesOnly: Binding<Bool>
        let movies: [MovieItem<Row, Details>]
        
        struct MovieItem<Row: View, Details: View>: Identifiable {
            let id: Movie.ID
            let row: Row
            let details: Details
        }
    }
    
    func map(state: AppState, dispatch: @escaping (Action) -> Void) -> Props<Row, Details>  {
        let showFavoritesOnly = Binding<Bool>(
            getValue: { state.showFavoritesOnly },
            setValue: { dispatch(Actions.ToggleFavoritesOnly(shouldShowFavorites: $0))}
        )
        
        let allMovies = state.allMovies.compactMap { id in
            state.movieByID[id]
        }
        
        let visibleMovies = allMovies.filter { movie in
            if state.showFavoritesOnly {
                return state.favoriteMovies.contains(movie.id)
            } else {
                return true
            }
        }
        
        let movieItems = visibleMovies.map { movie in
            MoviesList.Props.MovieItem(
                id: movie.id,
                row: row(movie.id),
                details: details(movie.id))
        }
        
        return Props(
            showFavoritesOnly: showFavoritesOnly,
            movies: movieItems)
    }
    
    static func body(props: Props<Row, Details>) -> some View {
        NavigationView {
            List {
                Toggle(isOn: props.showFavoritesOnly) {
                    Text("Show Favorites Only")
                }
                
                ForEach(props.movies) { movie in
                    NavigationButton(destination: movie.details) {
                        movie.row
                    }
                }
            }.navigationBarTitle(Text("Movies"), displayMode: .large)
        }
    }
}
