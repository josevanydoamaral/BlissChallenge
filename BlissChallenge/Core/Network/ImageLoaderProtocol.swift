import Foundation
import UIKit

protocol ImageLoaderProtocol {
    func loadImage(from url: URL) async -> UIImage?
}
