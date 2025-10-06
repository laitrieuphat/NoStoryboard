import UIKit

class StarView: UIView {
    
    // ImageView to display the star
    private let imageView = UIImageView()
    
    // Images for selected and unselected states
    private let selectedImage: UIImage
    private let unselectedImage: UIImage

    init() {
        selectedImage = UIImage(systemName: "star.fill")!.withTintColor(.yellow, renderingMode: .alwaysOriginal)
        unselectedImage = UIImage(systemName: "star")!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        super.init(frame: .zero)
        loadLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadLayout() {
        // Disable user interaction to ignore touch events on the individual star views.
        // Touch events will be handled in the parent view (StarsRateView).
        isUserInteractionEnabled = false

        // Setup the layout by adding the image view
        addSubview(imageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Layout the imageView
        imageView.frame = bounds
    }

    func setSelected(_ isSelected: Bool) {
        // Update the star image based on the selection state
        imageView.image = isSelected ? selectedImage : unselectedImage
    }
}
