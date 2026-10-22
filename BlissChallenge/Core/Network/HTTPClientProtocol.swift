import Foundation


protocol HTTPClientProtocol {
    func get(url: String) async throws -> Data
}
