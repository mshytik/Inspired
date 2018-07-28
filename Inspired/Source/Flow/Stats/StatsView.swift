import UIKit
import Charts

// MARK: StatsView

final class StatsView: UIView {
    
    // MARK: Types
    
    typealias ViewModel = StatsViewModel
    
    // MARK: Static
    
    static var viewHeight: CGFloat { return GUI.Height.total }
    
    // MARK: Properties
    
    private var viewModel: ViewModel?
    private let chartView = BarChartView()
    private let titleLabel = UILabel()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: Interface
    
    func configure(viewModel: ViewModel?) {
        self.viewModel = viewModel
        chartView.xAxis.valueFormatter = viewModel
        guard let viewModel = viewModel else { configureEmpty(); return }
        configure(viewModel: viewModel)
    }
    
    // MARK: Implementation
    
    private func configure(viewModel: ViewModel) {
        titleLabel.text = viewModel.composedTitle
        configureChart(viewModel)
    }
    
    private func configureChart(_ viewModel: ViewModel) {
        defer {
            chartView.tuned {
                $0.data?.notifyDataChanged()
                $0.notifyDataSetChanged()
            }
        }
        
        guard let set = chartView.data?.dataSets.first as? BarChartDataSet else {
            updateItems(viewModel.chartItems)
            return
        }
        
        set.values = viewModel.chartItems
    }
    
    private func updateItems(_ items: [BarChartDataEntry]) {
        BarChartDataSet(values: items, label: Char.empty).tuned {
            $0.colors = [Color.Chart.value]
            $0.form = .none
            $0.drawIconsEnabled = false
            $0.drawValuesEnabled = false
            $0.highlightEnabled = true
            $0.highlightColor = Color.Chart.highlight
            chartView.data = BarChartData(dataSet: $0).tuned { $0.barWidth = GUI.Chart.barWidth }
        }
    }
    
    private func configureEmpty() {
        
    }
    
    // MARK: Configuration
    
    private func configure() {
        width(Screen.width).height(GUI.Height.total)
        
        chartView.addTo(self).tuned {
            $0.top(self, Layout.margin).sides(self, GUI.Chart.margin).height(GUI.Height.chart)
            
            $0.chartDescription = Description().tuned { $0.text = Char.empty }
            $0.borderColor = Color.Chart.border
            
            $0.drawBordersEnabled = true
            $0.pinchZoomEnabled = false
            $0.doubleTapToZoomEnabled = false
            $0.rightAxis.enabled = false
            $0.setScaleEnabled(false)
        }
        
        let title = UIView().addTo(self).tuned {
            $0.bottom(self).sides(self).height(GUI.Height.label)
            $0.backgroundColor = Color.Bg.navBar
        }
        
        titleLabel.addTo(title).tuned {
            $0.left(title, Layout.margin).cy(title)
            $0.configureMultiline()
            $0.update(Font.statBar, Color.primary)
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
            $0.granularity = GUI.Chart.xGranularity
        }
        
        configureEmpty()
    }
    
    // MARK: GUI
    
    private enum GUI {
        enum Height {
            static let chart: CGFloat = 294
            static let label: CGFloat = 52
            static let titleOffset: CGFloat = -24
            static let total = chart + label
        }
        
        enum Chart {
            static let xGranularity: Double = 1
            static let axisMinimum: Double = 0
            static let barWidth: Double = 0.9
            static let spaceTop: CGFloat = 0.15
            static let margin: CGFloat = 12
        }
    }
}
