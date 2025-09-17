//
//  HomeService.swift
//  NoStoryboard
//
//  Created by Minh on 12/9/25.
//

import Foundation
protocol HomeServiceProtocol {
    func fetchBannerLinks(completion: @escaping (Result<[String], Error>) -> Void)
}

final class HomeService: HomeServiceProtocol {

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
