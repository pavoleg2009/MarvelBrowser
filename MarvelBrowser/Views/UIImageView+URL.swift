import UIKit

extension UIImageView {
    
    // MARK: - Constants
    private struct AssociationKey {
        static var dataTask = "pos_dataTask"
        static var session = "pos_imageDownloadSession"
    }
    
    // MARK: - Static Properties
    public static let imageDownloader = URLSession(configuration: .default)
    
    // MARK: - Instance Properties
    public var dataTask: URLSessionDataTask? {
        get {
            return objc_getAssociatedObject(self, &AssociationKey.dataTask) as? URLSessionDataTask
            
        } set {
            dataTask?.cancel()
            objc_setAssociatedObject(self, &AssociationKey.dataTask, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Instance Methods
    @discardableResult public func pos_setImage(url: URL?) -> URLSessionDataTask? {
        guard let url = url else {
            self.dataTask = nil
            image = nil
            return nil
        }
        let dataTask = UIImageView.imageDownloader.dataTask(
            with: url, completionHandler: { [weak self] (data, response, error) in
                guard let strongSelf = self else { return }
                guard let data = data, let image = UIImage(data: data) else {
                    print("Image download failed: \(String(describing: error))")
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let strongSelf = self else { return }
                        strongSelf.image = nil
                    }
                    
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.image = image
                }
        })
        dataTask.resume()
        self.dataTask = dataTask
        return dataTask
    }
}