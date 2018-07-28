import Foundation

// MARK: PhotoStatItem

class PhotoStatItem {
    let date: String
    let value: Int
    
    init(date: String, value: Int) {
        self.date = date
        self.value = value
    }
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
    let items = [PhotoStatItem(date: "2018-06-01", value: 215),
                 PhotoStatItem(date: "2018-06-01", value: 32),
                 PhotoStatItem(date: "2018-06-01", value: 17),
                 PhotoStatItem(date: "2018-06-01", value: 21),
                 PhotoStatItem(date: "2018-06-02", value: 54),
                 PhotoStatItem(date: "2018-06-03", value: 310),
                 PhotoStatItem(date: "2018-06-04", value: 541),
                 PhotoStatItem(date: "2018-06-05", value: 43),
                 PhotoStatItem(date: "2018-06-06", value: 52),
                 PhotoStatItem(date: "2018-06-07", value: 56),
                 PhotoStatItem(date: "2018-06-08", value: 23),
                 PhotoStatItem(date: "2018-06-09", value: 15),
                 PhotoStatItem(date: "2018-06-10", value: 32),
                 PhotoStatItem(date: "2018-06-11", value: 17),
                 PhotoStatItem(date: "2018-06-12", value: 45),
                 PhotoStatItem(date: "2018-06-13", value: 195),
                 PhotoStatItem(date: "2018-06-14", value: 198),
                 PhotoStatItem(date: "2018-06-15", value: 198),
                 PhotoStatItem(date: "2018-06-16", value: 43),
                 PhotoStatItem(date: "2018-06-17", value: 52),
                 PhotoStatItem(date: "2018-06-18", value: 56),
                 PhotoStatItem(date: "2018-06-19", value: 36),
                 PhotoStatItem(date: "2018-06-20", value: 215),
                 PhotoStatItem(date: "2018-06-21", value: 32),
                 PhotoStatItem(date: "2018-06-22", value: 17),
                 PhotoStatItem(date: "2018-06-23", value: 21),
                 PhotoStatItem(date: "2018-06-24", value: 54),
                 PhotoStatItem(date: "2018-06-25", value: 310),
                 PhotoStatItem(date: "2018-06-26", value: 541),
                 PhotoStatItem(date: "2018-06-27", value: 43),
                 PhotoStatItem(date: "2018-06-28", value: 43),
                 PhotoStatItem(date: "2018-06-29", value: 43),
                 PhotoStatItem(date: "2018-06-30", value: 43)]
    return PhotoStat(name: "Likes", totalValue: 815, items: items)
}
