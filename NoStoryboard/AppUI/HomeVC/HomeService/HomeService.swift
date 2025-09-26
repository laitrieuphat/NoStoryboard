//
//  HomeService.swift
//  NoStoryboard
//
//  Created by Minh on 12/9/25.
//

import Foundation
protocol HomeServiceProtocol {
    func fetchBannerLinks(completion: @escaping (Result<[String], Error>) -> Void)
    func fetchOutstandingTours(completion: @escaping (Result<[Item], Error>) -> Void)
}

final class HomeService: HomeServiceProtocol {
    func fetchOutstandingTours(completion: @escaping (Result<[Item], any Error>) -> Void){
        DispatchQueue.global(qos: .background).async{
            do {
                let model: HomeModel = try LocalJSONLoader.load(HomeModel.self,
                                                                fromResource: "allData",
                                                                subdirectory: "LocalData")
                
                for item in model.likeTourData {
                    if item.id == 301{
                        completion(.success(item.items))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    
    func fetchBannerLinks(completion: @escaping (Result<[String], Error>) -> Void) {
        // Load the local JSON on a background queue to avoid blocking the main thread
        DispatchQueue.global(qos: .background).async {
            do {
                let model: HomeModel = try LocalJSONLoader.load(HomeModel.self,
                                                                fromResource: "allData",
                                                                subdirectory: "LocalData")
                completion(.success(model.bannerSlideLinks))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
