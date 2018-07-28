import Foundation

// MARK: PhotosProvider

final class PhotosProvider {
    
    // MARK: Types
    
    typealias PhotosCompletion = ResultCompletion<[Photo]>
    typealias StatsCompletion = ResultCompletion<PhotoStats>
    
    private enum Keys: String {
        case id, historical, total, change, values, date, value
    }
    
    // MARK: Feed
    
    static func fetchPhotos(completion: @escaping PhotosCompletion) {
        guard let url = Path.Unsplash.Api.feed else { return }
        Network.request(url, .get) { result in
            mainThread {
                switch result {
                case .success(let response): completion(.success(value: photos(with: response)))
                case .failure(let error): completion(.failure(error: error))
                }
            }
        }
    }
    
    private static func photos(with response: Network.JsonResponse) -> [Photo] {
        switch response {
        case .single(let json): return [Photo(json: json)]
        case .array(let jsons): return jsons.map { Photo(json: $0) }
        }
    }
    
    // MARK: Stats
    
    static func fetchStats(id: String, completion: @escaping StatsCompletion) {
        guard let url = Path.Unsplash.Api.stats(id: id) else { return }
        Network.request(url, .get) { result in
            mainThread {
                switch result {
                case .success(let response): completion(.success(value: stats(id, response)))
                case .failure(let error): completion(.failure(error: error))
                }
            }
        }
    }
    
    private static func stats(_ id: String, _ response: Network.JsonResponse) -> PhotoStats {
        guard case .single(let json) = response else { return PhotoStats(id: id, stats: []) }
        
        let itemMap: (Json) -> PhotoStatItem? = {
            guard
                let date = $0[Keys.date.rawValue] as? String,
                let value = $0[Keys.value.rawValue] as? Int else { return nil }
            return PhotoStatItem(date: date, value: value)
        }
        
        let statMap: (String) -> PhotoStat? = {
            guard
                $0 != Keys.id.rawValue,
                let statJson = json[$0] as? Json,
                let historical = statJson[Keys.historical.rawValue] as? Json,
                let total = statJson[Keys.total.rawValue] as? Int,
                let change = historical[Keys.change.rawValue] as? Int,
                let values = historical[Keys.values.rawValue] as? [Json] else { return nil }
            
            return PhotoStat(name: $0, periodValue: change, totalValue: total, items: values.compactMap(itemMap))
        }
        
        return PhotoStats(id: id, stats: json.keys.compactMap(statMap))
    }
}
