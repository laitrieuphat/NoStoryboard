//
//  HomeViewModel.swift
//  NoStoryboard
//
//  Created by Minh on 12/9/25.
//

import Foundation
import UIKit


final class HomeViewModel {
    private let service: HomeServiceProtocol
    private(set) var banners:Observerable<[String]> = Observerable([])
    private(set) var outstandingTours:Observerable<[Item]> = Observerable([])
    private(set) var largeBanners:Observerable<[String]> = Observerable([])
    
    var arrayCell = [
                     "BannerCollectionViewCell",
                     "InforCollectionViewCell",
                    "OutstandingTourCollectionViewCell",
                     "LargeBannerCollectionViewCell",
                     "ProductCollectionViewCell",
                     "CategoryCollectionViewCell",
                    "ProductCollectionViewCell"]
    init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }
    
    func loadingDataTourBy(type : TypeOfTour){
        self.service.fetchDataTour(by: type) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let tours):
                DispatchQueue.main.async {
                    self.outstandingTours.value = tours
                }
            case .failure(let error):
                self.outstandingTours.value = []
                print("HomeViewModel: failed to fetch outstanding tours - \(error)")
            }
        }
    }
    
    func loadBanners(){
        // Delegate JSON loading to the service which reads the local JSON using Codable
        service.fetchBannerLinks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let links):
                DispatchQueue.main.async {
                    self.banners.value = links
                }
            case .failure(let error):
                self.banners.value = []
                print("HomeViewModel: failed to fetch banner links - \(error)")
            }
        }
    }
}
