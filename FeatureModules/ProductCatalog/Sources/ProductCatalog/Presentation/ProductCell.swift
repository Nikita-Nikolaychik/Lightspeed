import UIKit
import Networking

final class ProductCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String { Self.description() }
    
    // MARK: - GUI
    
    private lazy var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Constants.iconSize, height: Constants.iconSize))
    private lazy var textsVStack = UIStackView(arrangedSubviews: [nameLabel, priceLabel, quantityLabel])
    private lazy var nameLabel = UILabel()
    private lazy var priceLabel = UILabel()
    private lazy var quantityLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureSubviews()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setters
    
    func set(_ item: ProductCatalog.Product) {
        nameLabel.text = item.title
        priceLabel.text = item.price
        quantityLabel.text = item.stock
        
        fetchImage(urlString: item.thumbnail)
    }
}

// MARK: - Layout

private extension ProductCell {
    func configureSubviews() {
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        textsVStack.axis = .vertical
        textsVStack.spacing = 4
        textsVStack.alignment = .leading
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 0
        
        priceLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        priceLabel.adjustsFontForContentSizeCategory = true
        priceLabel.textColor = .systemGreen
        priceLabel.numberOfLines = 1
        
        quantityLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        quantityLabel.adjustsFontForContentSizeCategory = true
        quantityLabel.textColor = .systemGray
        quantityLabel.numberOfLines = 1
        
        contentView.addSubview(imageView)
        contentView.addSubview(textsVStack)
    }
    
    func configureLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textsVStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 64),
            imageView.heightAnchor.constraint(equalToConstant: 64),
            
            textsVStack.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            textsVStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textsVStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            textsVStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - Image

// should be in base component
private extension ProductCell {
    func fetchImage(urlString: String) {
        Task { @MainActor in
            let image = await ImageLoader.shared.loadImage(from: urlString)
            let resizedImage = image?.resizeImage(targetSize: CGSize(width: 64, height: 64))
            imageView.image = resizedImage
        }
    }
}
// this as well should not be here
extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}

// MARK: - Constants

private enum Constants {
    static let iconSize = CGFloat(64)
}
