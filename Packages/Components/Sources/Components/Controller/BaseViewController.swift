import UIKit
import Combine

open class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    public var cancellables = Set<AnyCancellable>()
    
    // MARK: - GUI
    
    private var loaderView: UIView?
    
    // MARK: - Initialization
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Loader
    
    public func showLoader() {
        guard loaderView == nil else { return }
        
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.backgroundColor = UIColor.tertiarySystemBackground.withAlphaComponent(0.5)
        backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = backgroundView.center
        activityIndicator.startAnimating()
        
        backgroundView.addSubview(activityIndicator)
        
        view.addSubview(backgroundView)
        
        loaderView = backgroundView
    }
    
    public func stopLoader() {
        loaderView?.removeFromSuperview()
        loaderView = nil
    }
}
