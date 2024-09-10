//
//  MoviesMiddleware.swift
//  redux-arch
//
//  Created by Balogun Kayode on 10/09/2024.
//

import Foundation


func moviesMiddleware() -> MiddleWare<AppState> {
    return { state, action, dispatch in
        switch action {
        case let action as FetchMovies:
            WebService().getMoviesBy(search: action.search) { result in
                switch result {
                case .success(let movies):
                    if let movies = movies {
                        dispatch(SetMovies(movies: movies))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    // Consider dispatching an error action here
                }
            }
            
        case let action as FetchMovieDetails:
            WebService().getMovieDetailsBy(imdbId: action.imdbId) { result in
                switch result {
                case .success(let movieDetails):
                    dispatch(SetMovieDetails(details: movieDetails))
                case .failure(let error):
                    print(error.localizedDescription)
                    // Consider dispatching an error action here
                }
            }
        default:
            break
        }
    }
}
