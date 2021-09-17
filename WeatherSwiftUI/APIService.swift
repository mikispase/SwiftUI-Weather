import Foundation

public class APIService {
   public static let shared = APIService()
    
    public enum APIError:Error {
        case error(_ errorString:String)
    }
    
    public func getJSON<T:Decodable>(urlString:String,
                                     dateDecodingStrategy:JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                     keyDecodingStrategy:JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                     completion: @escaping (Result<T,APIError>) -> ()) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(NSLocalizedString("Error:Invalid url", comment: ""))))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            
            if let error = error {
                completion(.failure(.error("Error \(error.localizedDescription)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("Error: Data us corropt", comment: ""))))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            }catch let decodingError {
                completion(.failure(APIError.error("Error1: \(decodingError.localizedDescription)")))
            }
            
            
        }.resume()
        
        
    }
}
