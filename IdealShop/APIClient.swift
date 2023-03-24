import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

final class APIClient {
    static let shared = APIClient()
    let baseURL = "https://run.mocky.io/v3/"
    private init() {}
    
    func makeRequest<T: Decodable>(path: String) async throws -> T {
        guard let url = URL(string: baseURL+path) else { throw NetworkError.invalidURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw NetworkError.invalidResponse }
        guard let response = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.decodingError }
        return response
    }
}

