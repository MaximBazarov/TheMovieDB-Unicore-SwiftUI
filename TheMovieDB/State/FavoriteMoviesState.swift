import Foundation

typealias FavoriteMoviesState = [Movie.ID]

extension FavoriteMoviesState {
    static let initial = [Movie.ID]()
}

extension Reduce {

    static let favoriteMovies = AppState.reduce.favoriteMovies.withRules { match in
        match.on(Actions.ToggleMovieFavorite.self) { state, action in
            var new = state
            if state.contains(action.id) {
                new.removeAll { (id) -> Bool in
                    id == action.id
                }
            } else {
                new.append(action.id)
            }

            return new
        }
    }
}
