import UIKit
import Charts

// MARK: DetailsStatsView

final class DetailsStatsView: UIView {
    
    // MARK: Definition
    
    final class ViewModel: IValueFormatter {
        func stringForValue(_ value: Double,
                            entry: ChartDataEntry,
                            dataSetIndex: Int,
                            viewPortHandler: ViewPortHandler?) -> String { return String(Int(value)) }
        
        let stat: PhotoStat
        
        init(stat: PhotoStat) {
            self.stat = stat
        }
        
        var composedTitle: String {
            return stat.name.capitalized + ":" + Text.space + String(stat.totalValue)
        }
        
        var chartItems: [BarChartDataEntry] {
            return stat.items.enumerated().map {
                BarChartDataEntry(x: Double($0.offset), y: Double($0.element.value))
            }
        }
    }
    
    // MARK: Properties
    
    static var defaultViewModel: ViewModel { return ViewModel(stat: testStat()) }
    
    private let viewModel: ViewModel
    
    private let chartView = BarChartView()
    private let titleLabel = UILabel()
    
    // MARK: Init
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError(Text.Common.initNA) }
    
    // MARK: Configuration
    
    func updateUi() {
        titleLabel.text = viewModel.composedTitle
        
        let items = viewModel.chartItems
        
        if let dataSet = chartView.data?.dataSets.first as? BarChartDataSet {
            dataSet.values = items
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
        } else {
            let set = BarChartDataSet(values: items, label: "")
            set.colors = [.brown]
            set.valueColors = [.white]
            set.valueFont = Font.chartAxis
            set.highlightColor = .white
            set.valueFormatter = viewModel
            let data = BarChartData(dataSet: set)
            data.barWidth = 0.8
            chartView.data = data
        }
    }
    
    private func configure() {
        tuned {
            $0.width(Screen.width).height(GUI.height)
        }
        
        chartView.addTo(self).tuned {
            $0.top(self).left(self).height(GUI.chartHeight).width(Screen.width)
            $0.pinchZoomEnabled = false
            $0.doubleTapToZoomEnabled = false
            $0.setScaleEnabled(false)
            $0.drawGridBackgroundEnabled = false
            $0.chartDescription = Description().tuned { $0.text = Text.empty }
            $0.highlightFullBarEnabled = false
        }
        
        chartView.xAxis.tuned {
            $0.labelPosition = .bottom
            $0.drawGridLinesEnabled = false
            $0.labelTextColor = .white
            $0.granularity = 1
            $0.gridColor = .clear
        }
        
        chartView.leftAxis.tuned {
            $0.labelFont = Font.chartAxis
            $0.labelPosition = .insideChart
            $0.drawAxisLineEnabled = false
            $0.gridColor = .clear
            $0.labelTextColor = .white
            $0.spaceTop = 0.15
            $0.axisMinimum = 1
            $0.enabled = false
        }
        
        chartView.rightAxis.tuned {
            $0.enabled = false
        }
        
        updateUi()
    }
    
    // MARK: GUI
    
    private enum GUI {
        static let chartHeight: CGFloat = 294
        static let labelHeight: CGFloat = 44
        static let height = chartHeight + labelHeight
    }
}
