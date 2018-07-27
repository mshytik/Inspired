import Foundation

// MARK: PhotoStatItem

struct PhotoStatItem {
    let date: String
    let value: Int
}

// MARK: PhotoStat

struct PhotoStat {
    let name: String
    let totalValue: Int
    let items: [PhotoStatItem]
}

// MARK: PhotoStats

struct PhotoStats {
    let id: String
    let downloads: PhotoStat
    let views: PhotoStat
    let like: PhotoStat
}

// MARK: Test

func testStat() -> PhotoStat {
    let items = [PhotoStatItem(date: "", value: 215),
                 PhotoStatItem(date: "", value: 32),
                 PhotoStatItem(date: "", value: 17),
                 PhotoStatItem(date: "", value: 21),
                 PhotoStatItem(date: "", value: 54),
                 PhotoStatItem(date: "", value: 310),
                 PhotoStatItem(date: "", value: 541),
                 PhotoStatItem(date: "", value: 43),
                 PhotoStatItem(date: "", value: 52),
                 PhotoStatItem(date: "", value: 56),
                 PhotoStatItem(date: "", value: 23),
                 PhotoStatItem(date: "", value: 15),
                 PhotoStatItem(date: "", value: 32),
                 PhotoStatItem(date: "", value: 17),
                 PhotoStatItem(date: "", value: 45),
                 PhotoStatItem(date: "", value: 195),
                 PhotoStatItem(date: "", value: 198),
                 PhotoStatItem(date: "", value: 198),
                 PhotoStatItem(date: "", value: 43),
                 PhotoStatItem(date: "", value: 52),
                 PhotoStatItem(date: "", value: 56),
                 PhotoStatItem(date: "", value: 36)]
    return PhotoStat(name: "Likes", totalValue: 815, items: items)
}
