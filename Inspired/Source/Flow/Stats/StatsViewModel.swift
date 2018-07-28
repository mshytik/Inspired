import UIKit
import Charts

// MARK: StatsViewModel

final class StatsViewModel: IAxisValueFormatter {
    
    // MARK: Properties
    
    let stat: PhotoStat
    
    // MARK: Init
    
    init(stat: PhotoStat) {
        self.stat = stat
    }
    
    // MARK: Interface
    
    var composedTitle: String {
        let total = Text.Details.total + Char.space + stat.name.capitalized + Char.means + String(stat.totalValue)
        let period = Text.Details.lastMonth + Char.means + String(stat.periodValue)
        return total + Char.eol + period
    }
    
    var chartItems: [BarChartDataEntry] {
        return stat.items.enumerated().map { entry(x: $0.offset, y: $0.element.value) }
    }
    
    // MARK: Implementation
    
    private func entry(x: Int, y: Int) -> BarChartDataEntry {
        return BarChartDataEntry(x: Double(x), y: Double(y))
    }
    
    // MARK: IAxisValueFormatter
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard axis is XAxis else { return String(value) }
        guard let item = stat.items[safe: Int(value)] else { return Char.empty }
        return Format.prettyStatDate(item.date)
    }
}
