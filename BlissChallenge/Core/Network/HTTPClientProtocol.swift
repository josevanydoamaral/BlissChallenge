import Foundation


protocol HTTPClientProtocol {
    func get(url: String) async throws -> Data
    func getImage(from imageUrl: String) async throws -> Data
}
