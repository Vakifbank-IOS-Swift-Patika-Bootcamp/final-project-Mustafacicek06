//
//  GameClient.swift
//  GameRatingApp
//
//  Created by Mustafa Çiçek on 15.12.2022.
//

import Foundation
import Alamofire


final class GameClient {
    static let BASE_URL = "https://api.rawg.io/api/"
    
    static func getAllGames(completion: @escaping ([GameModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "games" + "?key=" + Constants.API_KEY
        handleResponse(urlString: urlString, responseType: Games.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
    /*
    static func getMovieDetail(movieId: Int, completion: @escaping (MovieDetailModel?, Error?) -> Void) {
        let urlString = BASE_URL + "/movie/" + String(movieId) + "?" + "&api_key=" + Constants.API_KEY
        handleResponse(urlString: urlString, responseType: MovieDetailModel.self, completion: completion)
    }
    */
    static private func handleResponse<T: Decodable>(urlString: String, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        AF.request(urlString).response { response in
            guard let data = response.value else {
                DispatchQueue.main.async {
                    completion(nil, response.error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
}
