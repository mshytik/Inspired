import UIKit

// MARK: Format

enum Format {
    static let publishOutDf = dateFormatter("dd MMM, HH:mm")
    static let publishInDf = dateFormatter("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
    static let statInDf = dateFormatter("yyyy-MM-dd")
    static let statOutDf = dateFormatter("MM/dd")
    
    static func prettyPublishDate(_ input: String) -> String {
        return format(input, publishInDf, publishOutDf)
    }
    
    static func prettyStatDate(_ input: String) -> String{
        return format(input, statInDf, statOutDf)
    }
}

// MARK: Helper

private func dateFormatter(_ format: String) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter
}

private func format(_ input: String, _ inFormatter: DateFormatter, _ outFormatter: DateFormatter) -> String {
    guard let date = inFormatter.date(from: input) else { return Char.empty }
    return outFormatter.string(from: date)
}
