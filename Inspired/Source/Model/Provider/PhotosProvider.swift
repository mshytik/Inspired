import Foundation

// MARK: PhotosProvider

final class PhotosProvider {
    
    // MARK: Types
    
    typealias PhotosCompletion = (Result<[Photo]>) -> Void
    
    // MARK: Interface
    
    static func fetchPhotos(completion: @escaping PhotosCompletion) {
        NetworkService.request(PathConfig.photos, .get) {
            switch $0 {
            case .success(let jsonResponse):
                switch jsonResponse {
                case .single(let json): completion(.success(value: [Photo(json: json)]))
                case .array(let jsons): completion(.success(value: jsons.map { Photo(json: $0) }))
                }
            case .failure(let error): completion(.failure(error: error))
            }
        }
    }
    
}
