struct AppState: Reducable {
    let movieByID: [Movie.ID: Movie]
    let allMovies: [Movie.ID]
    let favoriteMovies: FavoriteMoviesState
    let showFavoritesOnly: Bool
}

extension Reduce {
    
    static let state = AppState.reduce.with { state, action in
        AppState(
            movieByID: Reduce.movieByID(state.movieByID, action),
            allMovies: Reduce.allMovies(state.allMovies, action),
            favoriteMovies: Reduce.favoriteMovies(state.favoriteMovies, action),
            showFavoritesOnly: Reduce.showFavoritesOnly(state.showFavoritesOnly, action)
        )
    }


    static let movieByID = AppState.reduce.movieByID.withConstant

    static let allMovies = AppState.reduce.allMovies.withConstant

    static let showFavoritesOnly = AppState.reduce.showFavoritesOnly.withRules { match in
        match.on(Actions.ToggleFavoritesOnly.self) { state, action in
            action.shouldShowFavorites
        }
    }
}
