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
    private(set) var likeTourData:Observerable<[LikeTourDatum]> = Observerable([])
    private(set) var largeBanners:Observerable<[String]> = Observerable([])
    
    var arrItemsCell = [
        "BannerCollectionViewCell",
        "InforCollectionViewCell",
        "OutstandingTourCollectionViewCell",
        "LargeBannerCollectionViewCell",
        "InternationTourCollectionViewCell",
        "CategoryCollectionViewCell",
        "ProductCollectionViewCell"]
    init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }
    
    func loadingDataLikeTour()  {
        self.service.fetchDataLikeTour { [weak self] result in
            switch result {
            case .success(let tours):
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    strongSelf.likeTourData.value = tours
                }
            case .failure(let error):
                self?.likeTourData.value = []
                print("HomeViewModel: failed to fetch DataLikeTour tours - \(error)")
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
