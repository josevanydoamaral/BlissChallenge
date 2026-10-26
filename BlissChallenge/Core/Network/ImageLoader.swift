import UIKit
import Foundation

final class ImageLoader: ImageLoaderProtocol {
    
    static let shared = ImageLoader()
    
    private let cache = NSCache<NSURL, UIImage>()
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func loadImage(from url: URL) async -> UIImage? {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }
        
        
        do {
            let (data, response) = try await session.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299,
                let image = UIImage(data: data) {
                
                
                cache.setObject(image, forKey: url as NSURL)
                
                return image
            }
            
            return nil

        } catch {
            return nil
        }
        
    }
}
