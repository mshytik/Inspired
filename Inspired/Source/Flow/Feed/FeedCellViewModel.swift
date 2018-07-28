import UIKit

// MARK: FeedCellViewModel

final class FeedCellViewModel {
    
    // MARK: Static
    
    static var barHeight: CGFloat { return GUI.barHeight }
    
    // MARK: Properties
    
    private let photo: Photo
    
    // MARK: Init
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    // MARK: Accessors
    
    var fullWidthPhotoHeight: CGFloat {
        return min(Screen.width * (photo.height / photo.width), GUI.maxPhotoHeight)
    }
    
    var fullWidthCellHeight: CGFloat {
        return fullWidthPhotoHeight + GUI.barHeight
    }
    
    var fullWidthCellSize: CGSize {
        return CGSize(width: Screen.width, height: fullWidthCellHeight)
    }
    
    var title: String {
        let author = Text.Feed.authorPrefix + photo.name
        let date = Text.Feed.datePrefix + Format.prettyPublishDate(photo.date)
        return author + Char.eol + date
    }
    
    var photoUrlString: String {
        return photo.regularUrl
    }
    
    // MARK: GUI
    
    private struct GUI {
        static let maxPhotoHeight: CGFloat = 300
        static let barHeight: CGFloat = 52
    }
}
