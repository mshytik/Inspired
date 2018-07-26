import Foundation

// MARK: PhotosProvider

final class PhotosProvider {
    
    // MARK: Types
    
    typealias PhotosCompletion = (Result<[Photo]>) -> Void
    
    // MARK: Interface
    
    static func fetchPhotos(completion: @escaping PhotosCompletion) {
        guard let url = URL(string: PathConfig.photos) else { return }
        NetworkService.request(url, .get) { result in
            mainThread {
                switch result {
                case .success(let response): completion(.success(value: photos(with: response)))
                case .failure(let error): completion(.failure(error: error))
                }
            }
        }
    }
    
    // MARK: Helper
    
    private static func photos(with response: NetworkService.JsonResponse) -> [Photo] {
        switch response {
        case .single(let json): return [Photo(json: json)]
        case .array(let jsons): return jsons.map { Photo(json: $0) }
        }
    }
}
