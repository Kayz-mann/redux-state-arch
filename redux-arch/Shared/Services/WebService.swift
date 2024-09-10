//
//  WebService.swift
//  redux-arch
//
//  Created by Balogun Kayode on 09/09/2024.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case decodingError
    case noData
}

struct Constants {
    static let Urls = UrlConstants()
}

struct UrlConstants {
    static let moviesBaseURL = "http://www.omdbapi.com/"
    
    static func urlBySearch(search: String) -> String {
        "\(moviesBaseURL)?apikey=\(APIKeys.omdbAPIKey)&s=\(search)"
    }
    
    static func urlByImdbID(imdbId: String) -> String {
        "\(moviesBaseURL)?apikey=\(APIKeys.omdbAPIKey)&i=\(imdbId)"
    }
}

struct APIKeys {
    static let omdbAPIKey: String = {
        guard let apiKey = Bundle.main.infoDictionary?["OMDB_API_KEY"] as? String else {
            fatalError("OMDB API key not found in Info.plist")
        }
        return apiKey
    }()
}




struct MovieDetails: Codable {
    let Title: String
    let Year: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Plot: String
    let Poster: String
    let imdbRating: String
    let details: String
}

class WebService {
    
    func getMoviesBy(search: String, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        guard let encodedSearch = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let moviesURL = URL(string: UrlConstants.urlBySearch(search: encodedSearch)) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: moviesURL) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(movieResponse.movies))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func getMovieDetailsBy(imdbId: String, completion: @escaping (Result<MovieDetails, NetworkError>) -> Void) {
        guard let moviesURL = URL(string: UrlConstants.urlByImdbID(imdbId: imdbId)) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: moviesURL) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let movieDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
                completion(.success(movieDetails))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
