import Foundation

// MARK: NetworkService

final class NetworkService {
    
    // MARK: Types
    
    enum Method: String {
        case get = "GET", post = "POST", put = "PUT", delete = "DELETE"
    }
    
    enum NetworkError {
        static let domain = "inspiration.network.error"
        
        enum Code {
            static let badUrl = 8001, badParams = 8002, badData = 8003, badJson = 8004
        }
    }
    
    enum JsonResponse {
        case single(json: Json)
        case array(jsons: [Json])
    }
    
    typealias JsonCallback = (Result<JsonResponse>) -> Void
    
    // MARK: Public
    
    @discardableResult static func request(_ url: String,
                                           _ method: Method,
                                           _ params: Json? = nil,
                                           _ callback: @escaping JsonCallback) -> URLSessionTask? {
        guard let url = URL(string: url) else {
            callback(.failure(error: defaultError(code: NetworkError.Code.badUrl)))
            return nil
        }
        
        var data: Data?
        if let params = params {
            do {
                data = try JSONSerialization.data(withJSONObject: params)
            } catch {
                callback(.failure(error: defaultError(code: NetworkError.Code.badParams)))
                return nil
            }
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = data
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                callback(.failure(error: error))
                return
            }
            
            guard let data = data, let obj = try? JSONSerialization.jsonObject(with: data) else {
                callback(.failure(error: defaultError(code: NetworkError.Code.badData)))
                return
            }
            
            if let json = obj as? Json {
                callback(.success(value: .single(json: json)))
            } else if let jsons = obj as? [Json] {
                callback(.success(value: .array(jsons: jsons)))
            } else {
                callback(.failure(error: defaultError(code: NetworkError.Code.badJson)))
            }
        }
        
        task.resume()
        return task
    }
    
    // MARK: Private
    
    private static func defaultError(code: Int) -> NSError {
        return NSError(domain: NetworkError.domain, code: code, userInfo: nil)
    }
}
