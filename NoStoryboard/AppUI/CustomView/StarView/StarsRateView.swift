//
//  StarsRateView.swift
//  NoStoryboard
//
//  Created by Minh on 1/10/25.
//
import UIKit

class StarsRateView: UIControl {
    
    // Array to hold the StarView instances
    private var starsViews: [StarView] = []

    // Number of stars to display
    private let starsCount: Int

    init(starsCount: Int = 5) {
        self.starsCount = starsCount
        super.init(frame: .zero)
        loadLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard !starsViews.isEmpty else { return }

        // Start point for the first star
        var startPoint: CGPoint = CGPoint(x: Appearance.contentInsets.left,
                                          y: Appearance.contentInsets.top)
        
        // Position each star view
        for star in starsViews {
            star.frame = .init(origin: startPoint, size: Appearance.starSize)

            // Update the start point for the next star
            startPoint.x += Appearance.starSize.width + Appearance.spacing
        }
    }

    private func loadLayout() {
        // Setup the layout by creating and adding StarView instances
        starsViews = (0..<starsCount).map { _ in StarView() }
        starsViews.forEach { addSubview($0) }
    }
    // Other properties and methods...


       private struct Appearance {
           static let starSize = CGSize(width: 34, height: 34)
           static let spacing: CGFloat = 12
           static let contentInsets = UIEdgeInsets(top: 12, left: 30, bottom: 12, right: 30)
       }
}
