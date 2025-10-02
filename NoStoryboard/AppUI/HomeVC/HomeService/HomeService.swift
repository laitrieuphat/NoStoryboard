//
//  HomeService.swift
//  NoStoryboard
//
//  Created by Minh on 12/9/25.
//

import Foundation
enum TypeOfTour:Int{
    case outstanding = 301
    case international = 421
    case domestic = 423
    case group = 447
    
    func simpleDescription() -> String {
        switch self {
        case .outstanding:
            return "outstanding"
        case .international:
            return "international"
        case .domestic:
            return "domestic"
        case .group:
            return "group"
        }
    }
    
}
protocol HomeServiceProtocol {
    func fetchBannerLinks(completion: @escaping (Result<[String], Error>) -> Void)
    func fetchDataTour(by id:TypeOfTour ,completion: @escaping (Result<[Item], Error>) -> Void)
    func fetchLargeBanner(by id: TypeOfTour,
                          completion: @escaping (Result<String, Error>) -> Void)
}

final class HomeService: HomeServiceProtocol {
    func fetchLargeBanner(by id: TypeOfTour, completion: @escaping (Result<String, any Error>) -> Void) {
        
    }
    
    func fetchDataTour(by id:TypeOfTour, completion: @escaping (Result<[Item], any Error>) -> Void){
        DispatchQueue.global(qos: .background).async{
            do {
                var arrayItem:[Item] = []
                let model: HomeModel = try LocalJSONLoader.load(HomeModel.self,
                                                                fromResource: "allData",
                                                                subdirectory: "LocalData")
                // Collect all items from likeTourData
                for (_,value) in model.likeTourData.enumerated() {
                    let filteredItems = value.items.filter { !$0.titleName.hasPrefix("set-5-yellow-stars") }
                    if value.id == id.rawValue && !filteredItems.isEmpty{
                        arrayItem.append(contentsOf: filteredItems)
                    }
                }
                completion(.success(arrayItem))
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
