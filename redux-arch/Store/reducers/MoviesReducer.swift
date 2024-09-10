//
//  MoviesReducer.swift
//  redux-arch
//
//  Created by Balogun Kayode on 09/09/2024.
//

import Foundation

func moviesReducer(_ state: MovieState, _ action: Action) -> MovieState {
    var state = state
    
    switch action {
    case let action as SetMovies:
        state.movies = action.movies
    case let action as SetMovieDetails:
        state.selectedMovieDetail =  action.details
        
    default:
        break
    }
    
    return state
}
