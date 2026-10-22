import Foundation


enum NetworkError: Error {
    case invalidURL
    case serverError(Int)
    case rateLimit
    case notFoundOrUnauthorized(Int)
    case decodedError
    case unknown
}
