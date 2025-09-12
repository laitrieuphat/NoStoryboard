//
//  HomeViewModel.swift
//  NoStoryboard
//
//  Created by Minh on 12/9/25.
//

import Foundation


final class HomeViewModel {
    
    private let service: HomeServiceProtocol
    
    // Simple Banner model used by the view model
    struct Banner: Decodable {
        let urlString: String
        var url: URL? { URL(string: urlString) }
    }

    // Top-level structure matching local JSON file (we only need bannerSlideLinks here)
    private struct AllData: Decodable {
        let bannerSlideLinks: [String]?
    }
    
    private(set) var banners: [Banner] = []
    var onUpdate: (() -> Void)?
    
    
    
    init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }
    
    func loadBanners(){
        // Read local JSON from bundle subdirectory LocalData/allData.json
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            let bundle = Bundle.main
            guard let url = bundle.url(forResource: "allData", withExtension: "json", subdirectory: "LocalData") ?? bundle.url(forResource: "allData", withExtension: "json") else {
                print("HomeViewModel: allData.json not found in bundle")
                return
            }

            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let all = try decoder.decode(AllData.self, from: data)
                let links = all.bannerSlideLinks ?? []
                let banners = links.map { Banner(urlString: $0) }
                DispatchQueue.main.async {
                    self.banners = banners
                    self.onUpdate?()
                }
            } catch {
                print("HomeViewModel: failed to load/parse allData.json - \(error)")
            }
        }
    }
    
    
    
}
