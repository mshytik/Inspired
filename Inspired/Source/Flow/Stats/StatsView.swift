import UIKit
import Charts

// MARK: DetailsStatsView

final class StatsView: UIView {
    
    // MARK: Types
    
    typealias ViewModel = StatsViewModel
    
    // MARK: Properties
    
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
    
    // MARK: Render
    
    func updateUi() {
        titleLabel.text = viewModel.composedTitle
        configureChart()
    }
    
    private func configureChart() {
        guard let set = chartView.data?.dataSets.first as? BarChartDataSet else {
            updateItems(viewModel.chartItems)
            return
        }
        
        chartView.tuned {
            set.values = viewModel.chartItems
            $0.data?.notifyDataChanged()
            $0.notifyDataSetChanged()
        }
    }
    
    private func updateItems(_ items: [BarChartDataEntry]) {
        BarChartDataSet(values: items, label: Char.empty).tuned {
            $0.colors = [Color.Chart.value]
            $0.form = .none
            $0.drawIconsEnabled = false
            $0.drawValuesEnabled = false
            $0.highlightEnabled = false
            chartView.data = BarChartData(dataSet: $0).tuned { $0.barWidth = GUI.Chart.barWidth }
        }
    }
    
    // MARK: Configuration
    
    private func configure() {
        width(Screen.width).height(GUI.Height.total)
        
        chartView.addTo(self).tuned {
            $0.top(self, Layout.margin).left(self).height(GUI.Height.chart).width(Screen.width)
            
            $0.chartDescription = Description().tuned { $0.text = Char.empty }
            $0.borderColor = Color.Chart.border
            
            $0.drawBordersEnabled = true
            $0.pinchZoomEnabled = false
            $0.doubleTapToZoomEnabled = false
            $0.rightAxis.enabled = false
            $0.setScaleEnabled(false)
        }
        
        chartView.xAxis.tuned {
            $0.gridColor = Color.Chart.grid
            $0.labelTextColor = Color.Chart.label
            $0.labelFont = Font.chartAxis
            $0.labelPosition = .bottom
            
            $0.avoidFirstLastClippingEnabled = true
            $0.drawGridLinesEnabled = true
            $0.drawAxisLineEnabled = false
            
            $0.granularity = GUI.Chart.xGranularity
            $0.valueFormatter = viewModel
        }
        
        chartView.leftAxis.tuned {
            $0.gridColor = Color.Chart.grid
            $0.labelTextColor = Color.Chart.label
            $0.labelFont = Font.chartAxis
            $0.labelPosition = .outsideChart
            
            $0.drawGridLinesEnabled  = true
            $0.drawAxisLineEnabled = false
            
            $0.spaceTop = GUI.Chart.spaceTop
            $0.axisMinimum = GUI.Chart.axisMinimum
        }
        
        updateUi()
    }
    
    // MARK: GUI
    
    private enum GUI {
        enum Height {
            static let chart: CGFloat = 294
            static let label: CGFloat = 44
            static let total = chart + label
        }
        
        enum Chart {
            static let xGranularity: Double = 1
            static let axisMinimum: Double = 0
            static let barWidth: Double = 0.8
            static let spaceTop: CGFloat = 0.15
        }
    }
    
    // MARK: Temp
    
    static var defaultViewModel: ViewModel {
        return ViewModel(stat: testStat())
    }
}
