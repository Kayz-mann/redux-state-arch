//
//  MovieView.swift
//  redux-arch
//
//  Created by Balogun Kayode on 10/09/2024.
//

import SwiftUI

struct MovieView: View {
    @EnvironmentObject var store: Store<AppState>
    @State private var search: String = ""
    
    struct Props {
        let movies: [Movie]
        let onSearch: (String) -> Void
    }
    
    private func map(state: MovieState) -> Props {
        Props(movies: state.movies, onSearch: { keyword in
            store.dispatch(action: FetchMovies(search: keyword))
        })
    }
    
    var body: some View {
        let props =  map(state: store.state.movies)
       
        VStack {
            TextField("Search", text: $search, onEditingChanged: {
                _ in
                
            },
                onCommit: {
                props.onSearch(search)
            }
            )
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            List(props.movies, id: \.imdbId) { movie in
                MovieCell(movie: movie)
            }.listStyle(PlainListStyle())
        }
        .navigationTitle("Movies")
        .embedInNavigationView()
    }
}

struct MovieCell: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: movie.poster))
                .frame(width: 100, height: 125)
                .cornerRadius(10)
            Text(movie.title)
        }
    }
}

#Preview {
    MovieView()
}
