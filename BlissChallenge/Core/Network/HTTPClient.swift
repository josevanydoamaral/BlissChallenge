import Foundation


class HTTPClient: HTTPClientProtocol {
    func get(url: String) async throws -> Data {
        guard let validURL = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: validURL)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return data
        case 403:
            throw NetworkError.rateLimit
        case 400...499:
            throw NetworkError.notFoundOrUnauthorized(httpResponse.statusCode)
        case 500...599:
            throw NetworkError.serverError(httpResponse.statusCode)
        default:
            throw NetworkError.unknown
        }
    }
    
    func getImage(from imageUrl: String) async throws -> Data {
        guard let url = URL(string: imageUrl) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return data
        case 403:
            throw NetworkError.rateLimit
        case 400...499:
            throw NetworkError.notFoundOrUnauthorized(httpResponse.statusCode)
        case 500...599:
            throw NetworkError.serverError(httpResponse.statusCode)
        default:
            throw NetworkError.unknown
        }
    }
    
    
}
