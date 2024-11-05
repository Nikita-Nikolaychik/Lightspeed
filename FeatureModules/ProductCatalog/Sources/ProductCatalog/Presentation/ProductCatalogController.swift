import UIKit
import Components

protocol ProductCatalogDisplayLogic: UIViewController {
    var viewModel: ProductCatalogViewModelLogic { get }
}

final class ProductCatalogController: BaseViewController, ProductCatalogDisplayLogic {
    
    // MARK: - Properties
    
    let viewModel: ProductCatalogViewModelLogic
    
    // MARK: - GUI
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionLayout())
    private lazy var refreshControl = UIRefreshControl()
    
    // MARK: - Initialization
    
    init(viewModel: ProductCatalogViewModelLogic) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureLayout()
        bindInput()
        
        viewModel.viewLoaded()
    }
}

// MARK: - Layout

private extension ProductCatalogController {
    func configureSubviews() {
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func makeCollectionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(90))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(90))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            
            return section
        }
    }
}

// MARK: - Binding

private extension ProductCatalogController {
    func bindInput() {
        viewModel.state
            .sink { [weak self] state in
                switch state {
                case .loadingFailed:
                    self?.refreshControl.endRefreshing()
                    // alertService.showFailAlert()
                case .reloadItems:
                    self?.refreshControl.endRefreshing()
                    self?.collectionView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    @objc func handleRefresh() {
        viewModel.refreshItems()
    }
}

// MARK: - UICollectionViewDataSource

extension ProductCatalogController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell
        let item = viewModel.products[indexPath.item]
        cell?.set(item)
        
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - Constants

private enum Constants {
//    static let
}
